class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'プログラミング' },
    { id: 3, name: '筋トレ' },
    { id: 4, name: 'ダイエット' },
    { id: 5, name: '英語学習' },
    { id: 6, name: '大学受験' },
    { id: 7, name: 'ブログ執筆' },
    { id: 8, name: 'その他' },
  ]

  include ActiveHash::Associations
  has_many :users
  end
