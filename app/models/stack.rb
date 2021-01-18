class Stack < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :work_time

  with_options presence: true do
    validates :text
    validates :date
  end

  def start_time
    date
  end
end
