# noop-remastered

Example commands to generate catalog and use it as a static input for the consuquent puppet apply:
```
 $ export PUPPET_GEM_VERSION='~>6.7.2'
 $ bundle update
 $ bundle exec rake rspec  # assuming it produces ../catalogs/init_centos8.json
 $ bundle exec puppet apply --trace -vd --use_cached_catalog \
   --pluginsource=file:///tmp/foo --plugindest=/tmp/foo \
   --pluginfactsource=file:///tmp/foo --pluginfactdest=/tmp/foo \
   --write-catalog-summary --loadclasses \
   --catalog ../catalogs/init_centos8.json manifests/init.pp
```

