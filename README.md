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

## 運用記録
　ブログにて運用のあれこれを記録する。
https://spreadthec0ntents.com/entry/2021/11/16/S%26P500%E3%81%AE%E8%B2%B7%E3%81%84%E6%99%82%E3%81%8C%E3%82%8F%E3%81%8B%E3%82%8B%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%81%A3%E3%81%A6%E3%81%BF%E3%81%9F
