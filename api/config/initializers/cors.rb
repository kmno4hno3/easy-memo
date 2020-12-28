# config.middleware.insert_before 0, Rack::Cors do
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # APIを実行するドメイン 今回は、フロントはlocalhost:8080で立ち上げるので、以下の通り
    origins "localhost:8080"
    # アクセスしていいリクエストを定義表現が使えたので、/api以下に制限した。
    # credentials: true を付与することでsession・cookieのやり取りができる
    resource "^/api",
             headers: :any,
             methods: [:get, :post, :patch, :delete, :head, :options],
             credentials: true
  end
end