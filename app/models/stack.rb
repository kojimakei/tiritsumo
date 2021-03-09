class Stack < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :stack_tags
  has_many :tags, through: :stack_tags

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :work_time

  with_options presence: true do
    validates :text, length: { maximum: 20 }
    validates :date
  end

  # dateカラムに未来の日付を選択できないように指定する
  validate :date_before_finish

  def date_before_finish
    return if date.blank?

    errors.add(:date, 'は過去の日付、もしくは本日の日付を選択してください') if date > Date.today
  end

  def start_time
    date
  end

end
