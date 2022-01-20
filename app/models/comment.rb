class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  broadcasts_to :post

  validates :content, presence: true
end
