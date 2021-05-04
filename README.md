# noop-remastered

Example commands to generate catalog and use it as a static input for the consequent puppet apply:
```
 $ git clone -b tripleo https://github.com/bogdando/noop-remastered test
 $ rsync -avxH test /usr/share/openstack-puppet/modules
```
Within a container for puppet configs:
``` 
 $ gem install rspec-puppet
 $ cd /usr/share/openstack-puppet/modules/test                  
 $ SPEC_MODULE_PATH=/usr/share/openstack-puppet/modules \
   SPEC_FACTS_DIR=/opt/puppetlabs/facter/cache/cached_facts \
   SPEC_FACTS_NAME=all_steps.json \
   SPEC_ROOT_DIR=/tmp rspec
 $ puppet apply --trace -vd --catalog /tmp/catalogs/init_all_steps_catalog.json
```
Now even if you change `test/manifests/init.pp`, the cached catalog will be used ignoring
the changes, unless it's updated (recompiled).
