#!/bin/bash

# TKIPの場合の設定を行います。この関数は引数が必要です
# $1 : SSID
# $2 : TKIP(WPA-PSK)のパスワード

# 無線LANデバイスは wlan0 と想定して決め打ちしてあります
# この設定ファイルを用いて:
# wpa_supplicant -Dwext -iwlan0 -c/etc/wpa_supplicant-wlan0.conf
# とすることでTKIPによってつながります
FILEPATH="/etc/wpa_supplicant-wlan0.conf"

wpa_passphrase $1 $2 | sed -e "s/\}//g" > $FILEPATH
cat >> $FILEPATH << .
        proto=WPA
        key_mgmt=WPA-PSK
        pairwise=CCMP TKIP
        group=CCMP TKIP
}
.

### パスワードメモの消去
# sed -e "s/#psk.*$//g" $FILEPATH > /tmp/a
# cp -f /tmp/a $FILEPATH
# rm /tmp/a

chmod 600 $FILEPATH

