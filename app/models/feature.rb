class Feature < ApplicationRecord
  belongs_to :project
  has_one_attached :image

  validates :title, presence: true
end
