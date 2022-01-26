class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates_presence_of :title

  has_rich_text :content

  scope :past_week, -> { where(created_at: Time.zone.now.at_beginning_of_week..Time.zone.now.at_end_of_week)}
  # scope :past_week, -> { where(created_at: 1.week.ago.beginning_of_week..1.week.ago.end_of_week) }
  scope :desc, -> { order(created_at: :desc) }
end
 