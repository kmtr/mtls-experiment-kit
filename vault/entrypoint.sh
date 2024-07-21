#!/bin/sh

# Vaultサーバーをバックグラウンドで起動
vault server -dev &
VAULT_PID=$!

# Vaultサーバーが起動するまで待機
sleep 3

# 初期設定スクリプトを実行
/vault/init.sh

# Vaultサーバーのプロセスをフォアグラウンドで再開
wait $VAULT_PID
