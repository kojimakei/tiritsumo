class Age < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '15〜19歳' },
    { id: 3, name: '20〜24歳' },
    { id: 4, name: '25〜29歳' },
    { id: 5, name: '30〜34歳' },
    { id: 6, name: '35〜39歳' },
    { id: 7, name: '40〜44歳' },
    { id: 8, name: '45〜49歳' },
    { id: 9, name: '50〜54歳' },
    { id: 10, name: '55〜59歳' },
    { id: 11, name: '60〜64歳' },
    { id: 12, name: '65〜69歳' },
  ]

  include ActiveHash::Associations
  has_many :users
  end
