# このファイルをRailsのconfigディレクトリにコピーしてください。
# その後、Railsのtmpディレクトリに以下のディレクトリを作成してください。
#
# tmp/sockets
# tmp/pids

app_dir = File.expand_path("../..", __FILE__)
tmp_dir = "#{app_dir}/tmp"
bind "unix://#{tmp_dir}/sockets/puma.sock"
pidfile "#{tmp_dir}/pids/puma.pid"
state_path "#{tmp_dir}/pids/puma.state"

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
preload_app!
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
plugin :tmp_restart
