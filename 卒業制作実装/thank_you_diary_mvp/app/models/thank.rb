class Thank < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 200 }
end
