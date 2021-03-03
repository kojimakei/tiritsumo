class Room < ApplicationRecord
  # アソシエーション
  has_many :chats, dependent: :destroy
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_one_attached :image
  # バリデーション
  validates :name, presence: true

  def self.search(search)
    if search != ''
      Room.where('name LIKE(?)', "%#{search}%")
    else
      Room.all
    end
  end
end
