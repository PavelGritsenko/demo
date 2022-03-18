class User < ApplicationRecord  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :posts, dependent: :destroy

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  validates :name, presence: true

  before_validation :ensure_name_has_a_value

  private
    def ensure_name_has_a_value
      if name.blank?
        self.name = email.split('@')[0] unless email.blank?
      end
    end
end
