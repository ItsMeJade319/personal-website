class Technology < ApplicationRecord
  has_many :project_technologies, dependent: :destroy
  has_many :projects, through: :project_technologies

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_s
    name
  end
end
