class User < ApplicationRecord
  # ※※※※※アソシエーション※※※※※
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :stacks
  has_many :comments
  has_many :likes, dependent: :destroy
  # has_many :liked_stacks, through: :likes, source: :stack
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  has_many :chats

  def already_liked?(stack)
    likes.where(stack_id: stack.id).exists?
  end

  def already_joined?(room)
    user_rooms.where(room_id: room.id).exists?
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :age
  belongs_to :occupation
  belongs_to :category
  has_one_attached :image

  # ※※※※※バリデーション※※※※※
  with_options presence: true do
    validates :email
    validates :nickname, length: { maximum: 10 }
    validates :goal
    validates :deadline
  end

  validates_format_of :password, with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

  validates :category_id,   numericality: { other_than: 1 }
  validates :occupation_id, numericality: { other_than: 1 }
  validates :age_id,        numericality: { other_than: 1 }

  # deadlineカラムに過去の日付を選択できないように指定する
  validate :date_before_start
  def date_before_start
    return if deadline.blank?

    errors.add(:deadline, 'は今日以降のものを選択してください') if deadline < Date.today
  end

  # ※※※※※ゲストログイン※※※※※
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = '佐藤太郎'
      user.category_id = 4
      user.age_id = 5
      user.occupation_id = 10
      user.deadline = '2021-03-31 00:00:00'
      user.goal = '10キロ痩せる'
    end
  end
end
