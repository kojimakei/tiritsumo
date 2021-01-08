class Stack < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :work_time

  with_options presence: true do
    validates :text
    validates :date
  end
end
