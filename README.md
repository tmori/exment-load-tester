# 概要
`exment-load-tester`は、[web-server-load-tester](https://github.com/tmori/web-server-load-tester)を利用して、[Exment API](https://exment.net/reference/ja/webapi.html)で Exment サーバーの負荷テストを行うツールです。

Exment APIのコール処理は、以下のドライバを利用しています。

- [PHP ドライバ](https://github.com/tmori/php-exment-driver)

負荷テストで計測する Exment のAPIは以下です。

- [カスタムデータ新規作成](https://exment.net/reference/ja/webapi.html#operation/post-values)
- [カスタムデータ情報更新](https://exment.net/reference/ja/webapi.html#operation/put-value)
- [カスタムデータ情報取得](https://exment.net/reference/ja/webapi.html#operation/get-value)
- [カスタムデータ検索](https://exment.net/reference/ja/webapi.html#operation/get-values-query)

また、負荷テストに必要なExmentのテストデータは[バックアップファイル](https://github.com/tmori/exment-load-tester/tree/main/load-test/backup)をリストアして作成します。

# テスト項目

[web-server-load-tester](https://github.com/tmori/web-server-load-tester)の機能を利用することで、テスト項目はCSVファイルで作成し、そのままテストを自動実行させます。

## カスタムデータ新規作成

最大で２００多重×５０連続で２５６文字のカラムが１８個あるテーブルにINSERTし続けるテストです。

https://github.com/tmori/exment-load-tester/blob/main/load-test/test-item/exment-create-item.csv

## カスタムデータ情報更新

`カスタムデータ新規作成`のテーブルデータに対して、最大で２００多重×５０連続でUPDATEし続けるテストです。

https://github.com/tmori/exment-load-tester/blob/main/load-test/test-item/exment-update-item.csv

## カスタムデータ情報取得

`カスタムデータ新規作成`のテーブルデータに対して、最大で２００多重×５０連続で View データ（１ページ分）を取得し続けるテストです。

https://github.com/tmori/exment-load-tester/blob/main/load-test/test-item/exment-view-item.csv

## カスタムデータ検索

`カスタムデータ新規作成`のテーブルデータに対して、、最大で２００多重×５０連続でフリーキーワード検索し続けるテストです。

https://github.com/tmori/exment-load-tester/blob/main/load-test/test-item/exment-query-item.csv

# テスト結果

テスト結果はこちらに自動的に格納されます。

https://github.com/tmori/exment-load-tester/tree/main/load-test/test-result/exment

なお、格納されているデータは、以下の環境で測定したものです。

* CPU: 8コア
* メモリ：16GB
* ディスク：15GB

## カスタムデータ新規作成

https://github.com/tmori/exment-load-tester/blob/main/load-test/test-result/exment/exment-create-item-result.csv

## カスタムデータ情報更新

https://github.com/tmori/exment-load-tester/blob/main/load-test/test-result/exment/exment-update-item-result.csv

## カスタムデータ情報取得

https://github.com/tmori/exment-load-tester/blob/main/load-test/test-result/exment/exment-view-item-result.csv

## カスタムデータ検索

https://github.com/tmori/exment-load-tester/blob/main/load-test/test-result/exment/exment-query-item-result.csv


# 前提とする環境

- Exment がインストールされていること
  - [ExmentをUbuntu20.0.4 サーバにインストールする手順](https://qiita.com/kanetugu2018/items/8192cc3461ef60b2f876)
- Linux環境で docker-compose が利用できる環境であること(Windows WSLは対象外)


# インストール手順

docker-compose.yml の [EXMENT_URL](https://github.com/tmori/exment-load-tester/blob/main/docker-compose.yml#L10) を適切なものに変更してください。


```
docker-compose build
```

```
docker-compose up -d
```

```
docker-compose exec exment_php /bin/bash
```

```
bash install.bash
```

テスト自動化していますので、パスワードなしで ssh で Exmentサーバーマシンにログインできる必要があります。
以下の記事が参考になります。

https://blog.apar.jp/linux/5336/
