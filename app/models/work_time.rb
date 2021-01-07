class WorkTime < ActiveHash::Base
  self.data = [
    { id: 1, name: '0.5時間' },
    { id: 2, name: '1時間' },
    { id: 3, name: '1.5時間' },
    { id: 4, name: '2時間' },
    { id: 5, name: '2.5時間' },
    { id: 6, name: '3時間' },
    { id: 7, name: '3.5時間' },
    { id: 8, name: '4時間' },
    { id: 9, name: '4.5時間' },
    { id: 10, name: '5時間' },
    { id: 11, name: '5.5時間' },
    { id: 12, name: '6時間' },
    { id: 13, name: '6.5時間' },
    { id: 14, name: '7時間' },
    { id: 15, name: '7.5時間' },
    { id: 16, name: '8時間' },
    { id: 17, name: '8.5時間' },
    { id: 18, name: '9時間' },
    { id: 19, name: '9.5時間' },
    { id: 20, name: '10時間' },
    { id: 21, name: '10.5時間' },
    { id: 22, name: '11時間' },
    { id: 23, name: '11.5時間' },
    { id: 24, name: '12時間' }
  ]

  include ActiveHash::Associations
  has_many :stacks
end


  