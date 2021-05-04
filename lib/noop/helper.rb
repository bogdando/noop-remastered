require 'rspec-puppet'

# Add fixture lib dirs to LOAD_PATH. Work-around for PUP-3336
Noop::Config.list_path_modules.each do |path|
  Dir["#{path}/*/lib"].entries.each do |lib_dir|
    $LOAD_PATH << lib_dir
  end
end

RSpec.configure do |c|
  c.mock_with :rspec
  c.module_path = '/usr/share/openstack-puppet/modules'
  c.manifest_dir = '/usr/share/openstack-puppet/modules/test/manifests'
  c.hiera_config = '/etc/puppet/hiera.yaml'
end

at_exit { RSpec::Puppet::Coverage.report! }
