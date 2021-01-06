class Stack < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :text
    validates :date
    validates :work_time
  end
end
