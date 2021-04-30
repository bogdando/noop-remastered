require 'json'

module Noop
  class Task
    # @return [Pathname]
    def file_name_facts
      return @file_name_facts if @file_name_facts
      self.file_name_facts = Noop::Utils.path_from_env 'SPEC_FACTS_NAME'
      return @file_name_facts if @file_name_facts
      self.file_name_facts = Noop::Config.default_facts_file_name
      @file_name_facts
    end
    alias :facts :file_name_facts

    # @return [Pathname]
    def file_name_facts=(value)
      return if value.nil?
      @file_name_facts = Noop::Utils.convert_to_path value
      @file_name_facts = @file_name_facts.sub_ext '.json' if @file_name_facts.extname == ''
    end
    alias :facts= :file_name_facts=

    # @return [Pathname]
    def file_base_facts
      file_name_facts.basename.sub_ext ''
    end

    # @return [Array<Pathname>]
    def file_paths_facts
      file_paths = Noop::Config.default_facts_cache_files
      file_paths += Dir.entries(Noop::Config.dir_path_facts).map do |e|
        Noop::Config.dir_path_facts + e
      end.select do |f|
        File.file? f
      end.map {|f| Pathname.new f}
      file_paths << Pathname.new(file_name_facts)
      file_paths.uniq
    end

    # @return [Array<String>]
    def facts_hierarchy
      file_paths_facts.select do |f|
        not f.empty? and  f.readable? or f.sub_ext('').readable?
      end
    end

    # @return [Hash]
    def facts_data
      facts_data = {}
      facts_hierarchy.each do |file_path|
        begin
          file_data = JSON.parse(File.read file_path)
          next unless file_data.is_a? Hash
          file_data = Noop::Utils.symbolize_hash_to_keys file_data
          facts_data.merge! file_data
        rescue
          next
        end
      end
      facts_data
    end

    # @return [String,nil]
    def hostname
      facts_data[:hostname]
    end

    # @return [String,nil]
    def fqdn
      facts_data[:fqdn]
    end

  end
end
