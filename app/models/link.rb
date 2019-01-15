class Link < ApplicationRecord
  belongs_to :user
  has_many :clicks

  validates :label, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :url, presence: true

  before_validation :set_unique_slug

  def self.generate_unique_slug
    loop do
      slug = SecureRandom.base58(3)
      break slug unless Link.where(slug: slug).exists?
    end
  end

  private

  def set_unique_slug
    self.slug = Link.generate_unique_slug if slug.blank?
  end
end
