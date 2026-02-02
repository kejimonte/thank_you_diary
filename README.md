## ER図

[![Image from Gyazo](https://i.gyazo.com/c012a2cee8dab869305c2f073169f3ba.png)](https://gyazo.com/c012a2cee8dab869305c2f073169f3ba)
---

## 本サービスの概要（700文字以内）

本サービスは、「自分のための感謝ログ」をコンセプトにした、感謝の気持ちを記録・振り返るためのWebアプリケーションです。  
日々忙しく働く20〜30代の社会人を主な対象とし、仕事や人間関係に追われる中で「気持ちを言語化する場所がない」「前向きな感情に目を向ける余裕がない」といった課題を解決することを目的としています。

ユーザーは日常の中で感じた小さな感謝や出来事を「感謝投稿」として記録できます。投稿にはテキストだけでなく画像やタグを付けることができ、自分の気持ちや出来事を整理しやすい設計になっています。また、下書き機能や公開・非公開の切り替えを設けることで、自分のペースで感謝を記録できます。

公開設定された感謝投稿は未ログインユーザーでも閲覧可能とし、他ユーザーの投稿を読むことで新たな気づきや共感を得ることもできます。本サービスは、他人と比較・競争するSNSではなく、「自分自身と向き合う時間」を大切にし、感謝を習慣化することで心の余裕を取り戻す体験を提供します。

---

## MVPで実装する予定の機能

- ユーザー登録・ログイン機能  
- メールアドレス・パスワード変更機能（メール認証）  
- 感謝投稿の作成・閲覧・編集・削除機能  
- 感謝投稿の下書き・公開／非公開切り替え機能  
- 画像付き感謝投稿機能（複数枚対応）  
- コメントの投稿・閲覧・編集・削除機能  
- タグの作成・編集・削除機能  
- タグによる感謝投稿の分類機能  
- 未ログインユーザーによる感謝投稿・コメントの閲覧機能  

---

## テーブル詳細

### users（ユーザー）

- id : bigint / 主キー  
- name : string / ユーザーの表示名  
- email : string / ログイン認証用メールアドレス（ユニーク制約）  
- encrypted_password : string / 暗号化されたパスワード  
- created_at : datetime / 作成日時  
- updated_at : datetime / 更新日時  

---

### posts（感謝投稿）

- id : bigint / 主キー  
- user_id : bigint / 投稿者のユーザーID（外部キー）  
- title : string / 感謝投稿のタイトル  
- body : text / 感謝内容の本文  
- is_public : boolean / 公開・非公開フラグ  
- status : string / 投稿状態（draft / published）  
- created_at : datetime / 作成日時  
- updated_at : datetime / 更新日時  

※ 画像はActiveStorageを使用し、複数枚添付可能としています。

---

### comments（コメント）

- id : bigint / 主キー  
- user_id : bigint / コメント投稿者のユーザーID（外部キー）  
- post_id : bigint / 紐づく感謝投稿ID（外部キー）  
- body : text / コメント本文  
- created_at : datetime / 作成日時  
- updated_at : datetime / 更新日時  

---

### tags（タグ）

- id : bigint / 主キー  
- name : string / タグ名  
- created_at : datetime / 作成日時  
- updated_at : datetime / 更新日時  

---

### post_tags（中間テーブル）

- id : bigint / 主キー  
- post_id : bigint / 感謝投稿ID（外部キー）  
- tag_id : bigint / タグID（外部キー）  
- created_at : datetime / 作成日時  
- updated_at : datetime / 更新日時  

---

## ER図の注意点

- [☑] プルリクエストに最新のER図スクリーンショットを画像が表示される形で掲載している  
- [☑] テーブル名は複数形で統一している  
- [☑] カラムの型を記載している  
- [☑] 外部キーを適切に設けている  
- [☑] STIは使用していない  
- [☑] postsテーブルに「post_name」などの冗長なカラム名は使用していない  
