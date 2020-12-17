FROM ruby:2.7.1

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \        
                       nodejs \
   && rm -rf /var/lib/apt/lists/* 

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD ./api/Gemfile $APP_ROOT/Gemfile
ADD ./api/Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets