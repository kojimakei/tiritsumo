class WorkTime < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '0.5' },
    { id: 2, name: '1' },
    { id: 3, name: '1.5' },
    { id: 4, name: '2' },
    { id: 5, name: '2.5' },
    { id: 6, name: '3' },
    { id: 7, name: '3.5' },
    { id: 8, name: '4' },
    { id: 9, name: '4.5' },
    { id: 10, name: '5' },
    { id: 11, name: '5.5' },
    { id: 12, name: '6' },
    { id: 13, name: '6.5' },
    { id: 14, name: '7' },
    { id: 15, name: '7.5' },
    { id: 16, name: '8' },
    { id: 17, name: '8.5' },
    { id: 18, name: '9' },
    { id: 19, name: '9.5' },
    { id: 20, name: '10' },
    { id: 21, name: '10.5' },
    { id: 22, name: '11' },
    { id: 23, name: '11.5' },
    { id: 24, name: '12' }
  ]

  include ActiveHash::Associations
  has_many :stacks
end
