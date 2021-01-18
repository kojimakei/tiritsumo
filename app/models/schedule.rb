class Schedule < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :plan, length: { maximum: 20 }
  validates :begin_time, presence:true
  validates :finish_time, presence:true

  def start_time
    date
  end

  # ※開始時間、終了時間が空欄または開始時間よりも終了時間が早い場合はエラー
  # def finish_time_is_after_begin_time
  #   errors.add(:end, "はstartより後の日時を指定してください") if starttime==nil || endtime==nil || starttime > endtime
  # end
end
