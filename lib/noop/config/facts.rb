require 'pathname'

module Noop
  module Config
    # @return [Pathname]
    def self.dir_path_facts
      return @dir_path_facts if @dir_path_facts
      @dir_path_facts = Noop::Utils.path_from_env 'SPEC_FACTS_DIR'
      begin
        @dir_path_facts = @dir_path_facts.realpath
      rescue
        @dir_path_facts
      end
    end

    def self.default_facts_file_name
      Pathname.new 'facts.json'
    end
    
    def self.default_facts_cache_files
      file_paths = []
      ['kernel', 'memory', 'networking', 'operating system', 'processor'].each do |item|
        file_paths << Pathname.new(Noop::Config.dir_path_facts + item)
      end
      file_paths
    end
  end
end
