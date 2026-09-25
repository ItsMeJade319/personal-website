class Project < ApplicationRecord
  has_one_attached :image
  has_many :features, -> { order(:position) }, dependent: :destroy
  has_many :project_technologies, dependent: :destroy
  has_many :technologies, through: :project_technologies

  accepts_nested_attributes_for :features, allow_destroy: true,
    reject_if: proc { |attrs| attrs["title"].blank? && attrs["description"].blank? }

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }
  before_save :set_published_at, if: -> { published? && published_at.blank? }
  before_save :assign_feature_positions

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true,
    format: { with: /\A[a-z0-9]+(-[a-z0-9]+)*\z/, message: "must be lowercase letters, numbers, and hyphens only" }
  validates :github_url, :demo_url, format: { with: %r{\Ahttps?://\S+\z}i, message: "must be a valid http(s) URL" }, allow_blank: true

  scope :published, -> { where(published: true).where(published_at: ..Time.current).order(published_at: :desc) }

  def to_param
    slug
  end

  def to_s
    title
  end

  # Lets the admin form edit technologies as one comma-separated text field
  # while the underlying data stays a proper many-to-many association.
  def technology_list
    technologies.map(&:name).join(", ")
  end

  def technology_list=(names)
    self.technologies = names.to_s.split(",").map(&:strip).reject(&:blank?).map do |name|
      Technology.where("lower(name) = ?", name.downcase).first_or_create!(name: name)
    end
  end

  private

  def generate_slug
    base_slug = title.parameterize
    candidate = base_slug
    suffix = 2

    while Project.where(slug: candidate).where.not(id: id).exists?
      candidate = "#{base_slug}-#{suffix}"
      suffix += 1
    end

    self.slug = candidate
  end

  def set_published_at
    self.published_at = Time.current
  end

  def assign_feature_positions
    features.each_with_index { |feature, index| feature.position = index }
  end
end
