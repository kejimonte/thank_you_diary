class Thank < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :thank_tags, dependent: :destroy
  has_many :tags, through: :thank_tags
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 200 }
end
