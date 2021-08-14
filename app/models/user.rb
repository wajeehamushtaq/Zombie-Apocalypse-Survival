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

  validates :name, :age, :gender, :email, :address, presence: true
  validates :email, uniqueness: true
  validates :name, length: { maximum: 20 }
  validates :age, numericality: { only_integer: true }
  validates_format_of :email,:with => Devise::email_regexp

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "150x150")
    else
      "/default.jpg"
    end
  end

  private
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default.jpg'
          )
        ), filename: 'default.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
