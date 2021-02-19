# TSUMI GAMES

<img width="1439" alt="reademe-top" src="https://user-images.githubusercontent.com/61346761/108021684-6cd5f800-7062-11eb-9c1a-7557e140eb2e.png">

### URL
https://www.tsumi-games.xyz/

### ゲストログイン
トップページのゲストログインボタン、或いはヘッダーのリンクより「guest_user」としてログイン可能です。

## 概要
買ったはいいもののプレイできずに溜まってしまったゲーム、いわゆる「積みゲー」を管理・共有するアプリです。

ついつい溜めてしまう積みゲーを効率的に管理できるようにしたい、またそれを共有し知らなかった名作や自分の好きそうなゲームに出会う機会を作りたいという思いから制作しました。

## 使用技術
・Ruby 2.7.0  
・Ruby on Rails 6.0.3  
・HTML  
・css  
・Javascript  
・jQuery  
・Docker/docker-compose  
・RSpec  
・MySQL 8.0  
・Nginx 1.12.2  
・AWS(Route53, VPC, EC2, RDS, S3, ALB, ACM)

![readme-network](https://user-images.githubusercontent.com/61346761/108066622-ebeb2080-70a2-11eb-87db-5b7a2a165ea0.png)

## 機能一覧
### ユーザー関連
・ユーザー登録/ログイン/編集 (devise, carrierwave)  
・ユーザー検索/並べ替え (ransack)  
・ユーザーのフォロー (ajax)  
