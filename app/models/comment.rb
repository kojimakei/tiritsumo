class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :stack

  validates :text, presence: true
end
