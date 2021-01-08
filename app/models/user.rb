class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :stacks
  has_many :comments
  with_options presence: true do
    validates :email
    validates :nickname
    validates :password
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'test'
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end
end
