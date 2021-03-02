class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :stack

  validates :text, presence: true,length: { maximum: 50 }
end
