class User < ApplicationRecord  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :posts, dependent: :destroy

  validates :name, presence: true

  before_validation :ensure_name_has_a_value

  private
    def ensure_name_has_a_value
      if name.blank?
        self.name = email.split('@')[0] unless email.blank?
      end
    end
end
