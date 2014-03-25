default[:monit][:unicorn][:pid_dir] = '/path/to/pids'
default[:monit][:unicorn][:master_pid] = "#{node[:monit][:unicorn][:master_pid]}/unicorn_master.pid"
default[:monit][:unicorn][:worker_count] = 1
