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

上記の環境構築前に、本負荷テスト実施時にいくつか各種設定調整が必要となりますので、以下の対応が必要となりますので、ご注意ください。

* Laravel のAPIリクエスト制限数の変更
 * 参考：[Laravel8で429エラーが出たときの対処法](https://zenn.dev/naoki_oshiumi/articles/e7a1e97ba858b4)
 * 本テストでは、`perHour(50000)`としました。
* Nginxのタイムアウト設定の変更
  * 多重度を上げると応答が極端に遅くなり、Nginxがタイムアウトエラーを返す場合があります。
  * 本テストでは、応答時間を確認したいため、タイムアウトにならないように設定変更する必要があります。
  * 本テストでの変更内容は以下としました。環境に応じて適宜パラメータを調整してください。
    * 修正対象ファイル: /etc/nginx/conf.d/exment.conf
    * パラメータ： fastcgi_read_timeout 600  * 
* MySQL の UNOD ログレコードサイズがページサイズを超える場合の対応
  * 参考：[§ InnoDB ストレージエンジン : InnoDB テーブルへの UPDATE ステートメントがハングする可能性があった。](https://openstandia.jp/oss_info/mysql/html/MySQL_5.5.18.html)
  * 本テストでは、MySQLのページサイズを 32KB としました。
    * ページサイズのパラメータ：innodb_page_size=32K
  * 注意：ページサイズの変更は、MySQLインストール(mysql_secure_installation)後に行うと、MySQLが起動しなくなります。
  * 注意：インストールしてしまった場合は、以下の手順で対応できます。
    * 1. 必要なデータをバックアップ
    * 2. [mysql を初期化](https://blog.turai.work/entry/20161011/1476170075)する。
    * 3. Mysqlを再インストール(mysql_secure_installation)する。
    * 4. [データベースをセットアップする](https://qiita.com/kanetugu2018/items/8192cc3461ef60b2f876#%E3%83%87%E3%83%BC%E3%82%BF%E3%83%BC%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97)。
    * 5. [初期データをインストールする](https://exment.net/docs/#/ja/quickstart_easy?id=%E5%88%9D%E6%9C%9F%E3%83%87%E3%83%BC%E3%82%BF%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
    * 6. バックアップデータをリストアする

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

テスト自動化していますので、以下の対応が必要となります。

* パスワードなしで ssh で Exmentサーバーマシンにログインできること。
  * 以下の記事が参考になります。
  * https://blog.apar.jp/linux/5336/
* www-data ユーザにパスワードなしで su できること（手順は後述）
* [Exment の API 設定を有効化する](https://exment.net/docs/#/ja/api)
  * 本テストでは、API Key(APIキー形式)を使用します。

## www-data ユーザにパスワードなしで su するための設定

### 1. su 権限設定を追加する。

```
	sudo vi /etc/pam.d/su 
	
	# This allows root to su without passwords (normal operation)
	#auth       sufficient pam_rootok.so
	auth       [success=ignore default=1] pam_succeed_if.so user = mattermost
	auth       sufficient   pam_succeed_if.so use_uid user ingroup mattermost
+	auth       [success=ignore default=1] pam_succeed_if.so user = www-data
+	auth       sufficient   pam_succeed_if.so use_uid user ingroup www-data
```

### 2. /etc/passwdの編集

www-data の `/usr/sbin/nologin` を `/bin/bash` に変更する

例：
```
www-data:x:33:33:www-data:/var/www:/bin/bash
````

### 3. www-dataのパスワード設定する

```
sudo passwd www-data
```

# 環境変数の設定

本ツールを実行するには以下の環境変数設定ファイル(env.bash)を編集する必要があります。

* ./web-server-load-tester/env/env.bash

ただし、上記の環境変数は一般向けのパラメータセットとなっているため、Exment負荷テスト用の環境変数を追加する必要があります。
ベースとなる設定ファイルは、[env_loadtest.bash](https://github.com/tmori/exment-load-tester/blob/main/load-test/env/env_loadtest.bash)があるので、その内容を上書きすることで必要な環境変数を追加することができます。

各環境変数設定内容として変更ポイントは以下の通りです。
ここで記載されていないものは、[web-server-load-tester](https://github.com/tmori/web-server-load-tester) のREADMEを参照ください。

* EXMENT_CLIENT_ID
  * Exment の API 設定で作成されたクライアントIDを設定します。
* EXMENT_CLIENT_SECRET
  * Exment の API 設定で作成されたクライアントシークレットを設定します。
* EXMENT_APK_KEY
  * Exment の API 設定で作成されたAPIキーを設定します。
* TEST_TARGET_TOOL_DIR
  * Exment サーバー側の web-server-load-tester のディレクトリパスです。
* EXMENT_TOOL_DIR
  * Exment サーバー側の 本ツールリポジトリのトップディレクトリパスです。


# テスト実行方法

docker コンテナに入り、以下のディレクトリに移動します。

★注意：ssh の設定は、コンテナからログアウトすると消えてしまいますので、毎回、実施しないといけないです。。

```
cd /root/workspace/web-server-load-tester
```

## カスタムデータ新規作成のテストを実行する場合

```
bash test-runtime/test-controller.bash ../load-test/test-item/exment-create-item.csv
```

## カスタムデータ情報更新のテストを実行する場合

```
bash test-runtime/test-controller.bash ../load-test/test-item/exment-update-item.csv
```

## カスタムデータ情報取得のテストを実行する場合

```
bash test-runtime/test-controller.bash ../load-test/test-item/exment-view-item.csv
```

## カスタムデータ検索のテストを実行する場合

```
bash test-runtime/test-controller.bash ../load-test/test-item/exment-query-item.csv
```


# 終了方法

```
docker-compose down
```
