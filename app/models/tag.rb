class Tag < ApplicationRecord
  has_many :stack_tags
  has_many :stacks, through: :stack_tags
end
