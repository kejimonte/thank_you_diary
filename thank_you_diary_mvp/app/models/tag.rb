class Tag < ApplicationRecord
  has_many :thank_tags, dependent: :destroy
  has_many :thanks, through: :thank_tags
end
