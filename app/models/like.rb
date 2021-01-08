class Like < ApplicationRecord
  belongs_to :user
  belongs_to :stack
  validates_uniqueness_of :stack_id, scope: :user_id
end
