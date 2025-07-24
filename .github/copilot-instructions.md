<img width="1024" height="1024" alt="Image" src="https://github.com/user-attachments/assets/4dd5ca09-186e-4a74-bed1-88f5811941bc" />

## 背景

現在、 https://optgeo.github.io/glob/#5.4/6.659/20.32 を利用する際、地図タイルの表示速度が十分に得られていません。これは gel.pmtiles が Source Cooperative から取得されているためであり、Source Cooperative は信頼性が高いものの、最近は帯域・速度が不足気味です。

## 課題

- gel.pmtiles のファイルサイズが非常に大きく、Cloudflare R2 の無料枠では収まりません。
- Source Cooperative からの直接取得では速度がボトルネックになっています。

## 解決策の概要

- gel.pmtiles をローカルのファイルシステムに保存し、Cloudflare Tunnel（cloudflared）経由で自宅サーバ（Raspberry Pi OS上）からサーブする方法を採用します（origin server in da house）。
- これはSmart Maps Module方式の再来です。

## タスク

1. gel.pmtiles のサイズを確認する（URL: https://data.source.coop/smartmaps/gel/gel.pmtiles）。
2. gel.pmtiles をローカルファイルシステムにダウンロード・保存する。
3. 今後の予定として、cloudflared をインストールした Raspberry Pi OS から gel.pmtiles を提供する構成を構築。

> ※本イシューでは主に1,2（ファイル保存）までをタスク化します。3は後続イシューで詳細化予定です。

## 補足

- gel.pmtiles は非常に大きいため、ダウンロード時はディスク容量・ネットワーク帯域に注意。
- 取得後のサーバ提供・Cloudflare Tunnel 構成は今後検討。

## Updated Instructions
- Ensure sensitive keys are not stored in the repository.
- Use environment variables for credentials.
- Document all major changes and findings in appropriate markdown files.
