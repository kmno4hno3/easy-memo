threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count # プールで利用できるスレッドの数
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }
plugin :tmp_restart # プラグイン読み込み:tmp/restart.txtをtouchするとリスタートする

app_root = File.expand_path("../..", __FILE__) # ルートディクトりの絶対パスを表示？

# サーバーをどのように接続するかをURIで指定
# 以下はwebサーバー(puma)の前段にnginxを置く場合にunix socket経由で接続
bind "unix://#{app_root}/tmp/sockets/puma.sock"

# 標準出力/標準エラーを出力するファイル
stdout_redirect "#{app_root}/log/puma.stdout.log", "#{app_root}/log/puma.stderr.log", true