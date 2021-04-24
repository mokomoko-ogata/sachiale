# テーブル設計

## Users テーブル

| Column                      | Type         | Options                   |
| --------------------------- | ------------ | ------------------------- |
| nickname                    | string       | null: false               |
| email                       | string       | null: false, unique: true |
| encrypted_password          | string       | null: false               |
| birthday                    | date         | null: false               |

### Association

- has_many :items
- has_many :comments
- has_many :blogs
- has_one  :buy_lists

## Items テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| item_name                   | string       | null: false                    |
| memo                        | text         |                                |
| category_id                 | integer      | null: false                    |
| amount                      | integer      | null: false                    |
| open_date                   | date         | null: false                    |
| user                        | references   | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :blogs, through::blog_items

## Blogs テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| recipe_name                 | string       | null: false                    |
| explain                     | text         | null: false                    |
| price                       | integer      | null: false                    |
| user                        | references   | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :items, through::blog_items
- has many :comments

## Blog_items テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| blog                        | references   | null :false, foreign_key: true |
| item                        | references   | null :false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## Comments テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| text                        | text         | null: false                    |
| blog                        | references   | null: false, foreign_key: true |
| user                        | references   | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :blog

## Buy_lists テーブル

| Column                      | Type         | Options                        |
| --------------------------- | ------------ | ------------------------------ |
| item_name                   | string       | null: false                    |
| memo                        | text         |                                |
| category_id                 | integer      | null: false                    |
| amount                      | integer      | null: false                    |
| user                        | references   | null: false, foreign_key: true |

### Association

- belongs_to :user
