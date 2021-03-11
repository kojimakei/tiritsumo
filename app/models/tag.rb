class Tag < ApplicationRecord
  has_many :stack_tags, dependent: :destroy
  has_many :stacks, through: :stack_tags
  validates :name, uniqueness: true
end
