require 'pathname'

module Noop
  module Config
    # The root directory of the config sub-module.
    # It's being used as the root for the relative paths
    # to the other directories.
    # @return [Pathname]
    def self.dir_path_config
      return @dirname if @dirname
      @dirname = Pathname.new(__FILE__).dirname.realpath
    end

    # The root directory of the fixtures module.
    # @return [Pathname]
    def self.dir_path_root
      return @dir_path_root if @dir_path_root
      @dir_path_root = Noop::Utils.path_from_env 'SPEC_ROOT_DIR'
      @dir_path_root = dir_path_config.parent.parent.parent unless @dir_path_root
      begin
        @dir_path_root = @dir_path_root.realpath
      rescue
        @dir_path_root
      end
    end

    # The directory where the task will chdir before being run.
    # Equals to the root dir unless specified.
    # @return [Pathname]
    def self.dir_path_task_root
      return @dir_path_task_root if @dir_path_task_root
      @dir_path_task_root = Noop::Utils.path_from_env 'SPEC_TASK_ROOT_DIR'
      @dir_path_task_root = dir_path_root unless @dir_path_task_root
      begin
        @dir_path_task_root = @dir_path_task_root.realpath
      rescue
        @dir_path_task_root
      end
    end

    # @return [Pathname]
    def self.dir_path_task_spec
      return @dir_path_task_spec if @dir_path_task_spec
      @dir_path_task_spec = Noop::Utils.path_from_env 'SPEC_SPEC_DIR'
      @dir_path_task_spec = dir_path_root + 'spec' + 'hosts' unless @dir_path_task_spec
      begin
        @dir_path_task_spec = @dir_path_task_spec.realpath
      rescue
        @dir_path_task_spec
      end
    end

    # @return [Array<Pathname>]
    def self.list_path_modules
      return @list_path_modules if @list_path_modules
      @list_path_modules = Noop::Utils.path_list_from_env 'SPEC_MODULEPATH', 'SPEC_MODULE_PATH'
      return @list_path_modules if @list_path_modules.any?
      @list_path_modules = [dir_path_root + 'modules']
    end

    # @return [Pathname]
    def self.dir_path_tasks_local
      return @dir_path_tasks_local if @dir_path_tasks_local
      @dir_path_tasks_local = Noop::Utils.path_from_env 'SPEC_TASK_DIR'
      @dir_path_tasks_local = dir_path_root + 'tasks' unless @dir_path_tasks_local
      begin
        @dir_path_tasks_local = @dir_path_tasks_local.realpath
      rescue
        @dir_path_tasks_local
      end
    end

    # @return [Pathname]
    def self.dir_path_modules_node
      return @dir_path_modules_node if @dir_path_modules_node
      @dir_path_modules_node = Pathname.new '/etc/puppet/modules'
    end

    # @return [Pathname]
    def self.dir_path_tasks_node
      return @dir_path_tasks_node if @dir_path_tasks_node
      @dir_path_tasks_node = dir_path_modules_node + 'tripleo' + 'manifests'
    end

    # Workspace directory where gem bundle will be created
    # is passed from Jenkins or the default value is used
    # @return [Pathname]
    def self.dir_path_workspace
      return @dir_path_workspace if @dir_path_workspace
      @dir_path_workspace = Noop::Utils.path_from_env 'WORKSPACE'
      @dir_path_workspace = Noop::Config.dir_path_root + Pathname.new('workspace') unless @dir_path_workspace
      begin
        @dir_path_workspace = @dir_path_workspace.realpath
      rescue
        nil
      end
      @dir_path_workspace.mkpath
      raise "Workspace '#{@dir_path_workspace}' is not a directory!" unless @dir_path_workspace.directory?
      @dir_path_workspace
    end

  end
end
