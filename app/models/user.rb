class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  acts_as_voter
  has_many :orders

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "150x150")
    else
      "/default.jpeg"
    end
  end

  private
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default.jpeg'
          )
        ), filename: 'default.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end
