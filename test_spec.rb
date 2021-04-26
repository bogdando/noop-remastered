require_relative 'spec_helper'
require_relative 'lib/noop'

manifest = 'test.pp'

shared_examples 'show_catalog' do
  it 'shows catalog contents' do
    Noop::Utils.output Noop::Utils.separator
    Noop::Utils.output Noop.task.catalog_dump self
    Noop::Utils.output Noop::Utils.separator
  end
end

shared_examples 'status' do
  it 'shows status' do
    Noop::Utils.output Noop::Utils.separator
    Noop::Utils.output Noop.task.status_report self
    Noop::Utils.output Noop::Utils.separator
    Noop::Utils.output Noop.task.gem_versions_report
    Noop::Utils.output Noop::Utils.separator
  end
end

shared_examples 'save_files_list' do
  it 'should save the list of File resources to the file' do
    Noop.task.catalog_file_report_write self
  end
end

shared_examples 'saved_catalog' do
  it 'should save the current task catalog to the file' do
    Noop.task.file_write_task_catalog self
  end
end

shared_examples 'console' do
  it 'runs pry console' do
    require 'pry'
    binding.pry
  end
end

###############################################################################

def run_test(manifest_file, *args)
  ENV['SPEC_TASK_DEBUG'] = 'yes'  
  ENV['SPEC_ROOT_DIR'] = '.'
  ENV['SPEC_MODULE_PATH'] = '.'
  ENV['SPEC_DEPLOYMENT_DIR'] = '.'
  ENV['SPEC_SPEC_DIR'] = '.'
  ENV['SPEC_TASK_DIR'] = '.'
  ENV['SPEC_REPORTS_DIR'] = '.'
  ENV['SPEC_FACTS_DIR'] = '.'
  Noop.task_spec = manifest_file

  Noop::Config.log.progname = 'noop_spec'
  Noop::Utils.debug "RSPEC: #{Noop.task.inspect}"

  let(:task) do
    Noop.task
  end

  let(:facts) do
    Noop.facts_data
  end

  before(:all) do
    begin
      Noop.setup_overrides
    rescue
      true
    end
  end

  #let(:ral_catalog) do
  #  Noop.create_ral_catalog self
  #end

  let (:catalog) do
    catalog = subject
    #catalog = Puppet::Resource::Catalog.new
    catalog = catalog.call if catalog.is_a? Proc
  end

  let (:ral) do
    ral = catalog.to_ral
    ral.finalize
    ral
  end

  let (:graph) do
    graph = Puppet::Graph::RelationshipGraph.new(Puppet::Graph::TitleHashPrioritizer.new)
    graph.populate_from(ral)
    graph
  end

  include_examples 'status'
  include_examples 'show_catalog'
  include_examples 'console' if ENV['SPEC_RSPEC_CONSOLE']
  include_examples 'save_files_list'
  include_examples 'saved_catalog'

  include_examples 'catalog'

  yield self if block_given?

end


describe manifest do
  shared_examples 'catalog' do
    let(:dump_catalog) do
      #Noop.dump_catalog self
      true
    end
  end
  run_test manifest
end
