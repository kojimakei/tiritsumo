class Room < ApplicationRecord
  # アソシエーション
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  # has_many :users, through: :user_rooms
  has_one_attached :image

  # ↓下記追加
  has_many :members, through: :user_rooms, source: :user
  belongs_to :user

  # バリデーション
  validates :name, presence: true
  # ルーム作成時にはユーザーが必要
  validates :habit, presence: true, length: { maximum: 50 }

  def self.search(search)
    if search != ''
      Room.where('name LIKE(?)', "%#{search}%")
    else
      Room.all
    end
  end
end
