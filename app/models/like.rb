class Like < ApplicationRecord
  belongs_to :user
  belongs_to :stack
  validates :user_id, uniqueness: { scope: :stack_id }
end
