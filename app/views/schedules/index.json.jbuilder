# https://qiita.com/matsubishi5/items/77fd05ad04cb43f800b1
# を参照


json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :plan
  json.date schedule.date
  json.begin schedule.begin_time
  json.finish schedule.finish_time
  json.url schedule_url(schedule)
end