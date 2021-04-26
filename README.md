# noop-remastered

Example commands to generate catalog and use it as a static input for the consequent puppet apply:
```
 $ export PUPPET_GEM_VERSION='~>6.7.2'
 $ bundle update
 $ bundle exec rake rspec  # compiles manifests/init.pp as ../catalogs/init_centos8.json
 $ bundle exec puppet apply --trace -vd --catalog ../catalogs/init_centos8.json
```
Now even if you change `manifests/init.pp`, the cached catalog will be used ignoring
the changes, unless it's updated (recompiled).
