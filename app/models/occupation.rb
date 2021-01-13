class Occupation < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '会社員（正社員）' },
    { id: 3, name: '会社員（契約社員）' },
    { id: 4, name: '公務員' },
    { id: 5, name: '自営業・自由業' },
    { id: 6, name: '会社役員・経営者' },
    { id: 7, name: 'パート・アルバイト' },
    { id: 8, name: '学生' },
    { id: 9, name: '専業主婦（夫）' },
    { id: 10, name: '無職' },
  ]

  include ActiveHash::Associations
  has_many :users

end
