require 'spec_helper'

manifest = 'init.pp'  # points manifests/init.pp (in SPEC_TASK_DIR)
test_class = 'test'   # points spec/classes/test_spec.rb (in SPEC_SPEC_DIR)

###############################################################################

def run_test(manifest_file, *args)
  ENV['SPEC_TASK_DEBUG'] = 'yes'  
  ENV['SPEC_ROOT_DIR'] = '.' # where to put generated catalog
  ENV['SPEC_MODULE_PATH'] = '../' # where to look for included resources
  ENV['SPEC_SPEC_DIR'] = 'spec/classes' # where to look for the test_class spec
  ENV['SPEC_TASK_DIR'] = 'manifests'  # where to look for the manifiest file
  ENV['SPEC_FACTS_DIR'] = 'cached_facts'  # contains cached facts
  ENV['SPEC_FACTS_NAME'] = 'top_facts.json' # custom overrides
  Noop.task_spec = manifest_file

  Noop::Config.log.progname = 'catalog-compile'
  Noop::Utils.debug "#{Noop.task.inspect}"

  let(:task) do
    Noop.task
  end

  let(:facts) do
    Noop.facts_data.merge({
        :step => 'custom'
      })
  end

  let (:catalog) do
    catalog = subject
    catalog = catalog.call if catalog.is_a? Proc
  end

  it 'should save the current task catalog to the file' do
    Noop.file_write_task_catalog self
  end

  yield self if block_given?
end

describe test_class do
  run_test manifest
end
