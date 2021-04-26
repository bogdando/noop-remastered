require 'json'

module Noop
  class Task

    # Dumps the entire catalog structure to JSON
    # @param env [String] the puppet environment to use for the compiled
    # catalog JSON file
    def catalog_dump_json(context, env='production')
      catalog = context.subject
      catalog = catalog.call if catalog.is_a? Proc
      catalog.environment = env
      JSON.pretty_generate(catalog)
    end

    # @return [Pathname]
    def dir_name_catalogs
      Pathname.new 'catalogs'
    end

    # @return [Pathname]
    def dir_path_catalogs
      Noop::Config.dir_path_root + dir_name_catalogs
    end

    # @return [Pathname]
    def file_name_task_catalog
      Noop::Utils.convert_to_path "#{file_name_base_task_report}.json"
    end

    # @return [Pathname]
    def file_path_task_catalog
      dir_path_catalogs + file_name_task_catalog
    end

    # Write the catalog files of this task
    # using the data from RSpec context
    # @param context [Object] the context from the rspec test
    # @return [void]
    def file_write_task_catalog(context)
      dir_path_catalogs.mkpath
      error "Catalog directory '#{dir_path_catalogs}' doesn't exist!" unless dir_path_catalogs.directory?
      debug "Writing catalog file: #{file_path_task_catalog}"
      File.open(file_path_task_catalog.to_s, 'w') do |file|
        file.puts catalog_dump_json context
      end
    end

  end
end
