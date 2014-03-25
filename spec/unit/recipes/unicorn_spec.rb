require 'spec_helper'

describe 'monit::unicorn' do
  let(:chef_run) { ChefSpec::Runner.new.converge described_recipe }

  it 'creates /etc/monit/conf.d/unicorn_master.conf' do
    expect(chef_run).to create_template('/etc/monit/conf.d/unicorn_master.conf').with(user: 'root', group: 'root', mode: 0644)

    # Can't assert on definitions without a hairy monkey patch: http://amespinosa.wordpress.com/2013/05/06/testing-recipe-definitions-with-chefspec/
    #expect(chef_run).to create_template('/etc/monit/conf.d/unicorn_master.conf').with_content('start program "/etc/init.d/unicorn start"')
  end

  it 'creates a unicorn_worker.conf file for each worker' do
    chef_run = ChefSpec::Runner.new do |node|
      node.set[:monit][:unicorn][:worker_count] = 2
    end.converge described_recipe

    expect(chef_run).to create_template('/etc/monit/conf.d/unicorn_workers.conf')

    # Can't assert on definitions without a hairy monkey patch: http://amespinosa.wordpress.com/2013/05/06/testing-recipe-definitions-with-chefspec/
    chef_run.node[:monit][:unicorn][:worker_count].times do |i|
      #expect(chef_run).to create_template('/etc/monit/conf.d/unicorn_workers.conf').with_content("with pidfile #{File.join(chef_run.node[:monit][:unicorn][:pid_dir], "worker.#{i}.pid")}")
    end
  end
end
