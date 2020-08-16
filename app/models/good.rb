class Good < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, presence: true

  def self.search(search)
    return Good.all unless search
    Good.where('name LIKE(?)', "%#{search}%")
  end
end
