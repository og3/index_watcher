# インデックス投資のために指数の動きを監視してLINEに通知するbot
## 仕様
　現時点での使用。
- S&P500指数のRSIが30を下回った時と、70を上回った時にLINEに通知する。
- データの出典：https://nikkeiyosoku.com/spx/rsi/

## 動作環境
- rails6
- ruby2.6.6
- heroku-20
- line_message_api

## 動作の詳細
- seleniumで「データの出典」のサイトに毎日定時でアクセスし、最新の日付のデータを取得する。
- 取得したデータ中のrsiがRSIが30を下回った時と、70を上回った時にLINEに通知する。
