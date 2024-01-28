---
title: WiGLE WiFi Wardrivingを利用したウォードライビング
date: 2024-01-28 14:58:11
category: Wireless
tags: 
    - 'Wireless' 
    - 'Wardriving'
---

世界中のWiFiアクセスポイントの情報を収集したデータベースとして [WiGLE.net](https://www.wigle.net/) というWebサイトがある。現在、2024年1月時点で12億を超える[\[1\]](https://www.wigle.net/)アクセスポイントを記録した膨大なデータベースはユーザの投稿によって成り立っている。各ユーザはウォードライビングなどの手法でWiFiアクセスポイントの情報を収集し、それらをWiGLE.net上の[投稿フォーム](https://wigle.net/uploads)から投稿する。

WiGLE.netは[WiGLE WiFi Wardriving](https://wigle.net/tools)と呼ばれるAndroid上で実行可能なウォードライビングツールを提供している。Androidの入ったスマートフォンがあれば、誰もが無線LANアクセスポイントに関する情報収集が可能である。

###### ※ウォードライビングとは
ウォードライビング(Wardriving)とは、移動中の乗り物から無線LANアクセスポイントを探す行為のことである。車に限らず"Wardriving"の表現を使うようだが、その移動手段によって、warbiking, warrailing, warwalkingなどのように別の表現を用いることもあるようである[\[2\]](https://en.wikipedia.org/wiki/Wardriving)。

## WiGLE WiFi Wardrivingによるウォードライビング
---
WiGLE WiFI Wardrivingの使い方について、簡単に説明する。
### インストール
インストールに関しては、Google Play Storeからインストールするだけである。

[WiGLE WiFi Wardriving - Google Play のアプリ](https://play.google.com/store/apps/details?id=net.wigle.wigleandroid)

ソースからビルドすることも可能だが、多くの場合そのような操作は不要だろう。
### ウォードライビングの開始
インストール後に位置情報の及び付近のデバイスの探索に関する権限を許可し、画面右上のメニューから"Scan On"を選択すれば、スキャンが開始される。
{% asset_img start_wardriving.png "スキャンの開始及び一時停止" %}

### 収集したデータの出力
収集したデータは、左上ハンバーガーバーから"Database"を選択し、"CSV Export Run"などを選択すればいい。Export Run/Export DBの違いについては、今回の起動で観測した分のみ出力するか、今まで確認したもの全て出力するかの違いである。

{% asset_img export_database.png "ハンバーガーバー > Database > CSV EXPORT RUN" %}
また、最下部に赤字で示された項目"CLEAR DB"でデータベースをリセットすることもできる。

### CSV出力の形式
"CSV EXPORT RUN"などで出力されるCSVは、以下のような形式である。MACアドレス, SSID, 及び緯度経度に関しては念の為伏せている。
```csv
WigleWifi-1.6,appRelease=2.84,model=Pixel 8,release=14,device=shiba,display=UQ1A.240105.004,board=shiba,brand=google,star=Sol,body=3,subBody=0
MAC,SSID,AuthMode,FirstSeen,Channel,Frequency,RSSI,CurrentLatitude,CurrentLongitude,AltitudeMeters,AccuracyMeters,RCOIs,MfgrId,Type
94:bf:c4:xx:xx:xx,XXXXXXXXX,[WPA2-PSK-CCMP][RSN-PSK-CCMP][ESS],2024-01-27 00:51:29,40,5200,■■■■,■■■■,63.59417991843205,39.2800407409668,,,WIFI
```
この出力から、以下のような形式であることがわかる。
- 1行目：実行環境
	読み込む際は、この行を無視するよう設定するといい。
- 2行目：列名
	このCSVに含まれる列名。ここから含まれるデータ項目がわかる。
- 3行目以降：実データ
	観測されたアクセスポイントに関する情報。

AuthMode列については分析するには少々扱いづらいので、正規化してから扱うといいだろう。

## まとめ
---
WiGLE WiFi Wardrivingの使い方について簡単に触れた。私はつい先日、実際にこのアプリを使って5000アクセスポイントほどのデータを収集した。2週間以内にこれについて簡単な分析を行い、レポートにまとめたいと思う。

## 参考
- \[1\] [WiGLE: Wireless Network Mapping](https://wigle.net/)
- \[2\] [Wardriving - Wikipedia](https://en.wikipedia.org/wiki/Wardriving)
