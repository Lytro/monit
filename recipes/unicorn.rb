include_recipe 'monit'

monitrc 'unicorn_master'
monitrc 'unicorn_workers'
