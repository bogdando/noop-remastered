require 'rspec-puppet'

require_relative '../lib/noop'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

# Add fixture lib dirs to LOAD_PATH. Work-around for PUP-3336
Noop::Config.list_path_modules.each do |path|
  Dir["#{path}/*/lib"].entries.each do |lib_dir|
    $LOAD_PATH << lib_dir
  end
end

RSpec.configure do |c|
  c.mock_with :rspec
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.hiera_config = '/etc/puppet/hiera.yaml'
end

at_exit { RSpec::Puppet::Coverage.report! }
