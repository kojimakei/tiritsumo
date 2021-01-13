# テーブル設計

## users テーブル

| Column             | Type     | Options                  |
| ------------------ | -------- | ------------------------ |
| nickname           | string   | null: false              |
| email              | string   | null: false, unique:true |
| encrypted_password | string   | null: false              |
| goal               | string   | null: false              |
| deadline           | datetime | null: false              |
| age_id             | integer  |                          |
| category_id        | integer  |                          |
| occupation_id      | integer  |                          |



### Association

- has_many :stacks
- has_many :comments
- has_many :likes
- has_many :schedules
- belongs_to_active_hash :category
- belongs_to_active_hash :occupation


## stacks テーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| date             | datetime    | null: false                    |
| text             | text        | null: false                    |
| work_time_id     | integer     |                                |
| user             | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_many :likes
- has_one :achievement


## achievements テーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| achieved         | boolean     | null: false                    |
| stack            | references  | null: false, foreign_key: true |

### Association

- belongs_to :stack


## schedules テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| date         | datetime   | null: false                    |
| begin_time   | datetime   | null: false                    |
| finish_time  | datetime   | null: false                    |
| plan         | text       | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user


## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| stack  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :stack



## likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| stack  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :stack


