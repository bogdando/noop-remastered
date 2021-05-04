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
  end
end
