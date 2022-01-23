# frozen_string_literal: true

chruby_version = "ruby-#{RUBY_VERSION}"
chruby_bin = '/usr/local/bin/chruby-exec'
chruby_cmd = "#{chruby_bin} #{chruby_version} --"
job_type :rake, "cd :path && #{chruby_cmd} :environment_variable=:environment bundle exec rake :task --silent :output"

set :chronic_options, hours24: true # rubocop:disable Naming/VariableNumber

every 1.day, at: '0:10' do
  rake 'db:sessions:trim'
end
