require 'spec_helper'
require_relative '../../lib/noop'

manifest = 'init.pp'  # points manifests/init.pp
test_class = 'test'

shared_examples 'saved_catalog' do
  it 'should save the current task catalog to the file' do
    Noop.file_write_task_catalog self
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
  ENV['SPEC_ROOT_DIR'] = '../'
  ENV['SPEC_MODULE_PATH'] = '../'
  ENV['SPEC_SPEC_DIR'] = 'spec/classes'
  ENV['SPEC_TASK_DIR'] = 'manifests'
  ENV['SPEC_FACTS_DIR'] = '../'
  Noop.task_spec = manifest_file

  Noop::Config.log.progname = 'catalog-compile'
  Noop::Utils.debug "#{Noop.task.inspect}"

  let(:task) do
    Noop.task
  end

  let (:catalog) do
    catalog = subject
    catalog = catalog.call if catalog.is_a? Proc
  end

  include_examples 'saved_catalog'

  yield self if block_given?

end

describe test_class do
  run_test manifest
end
