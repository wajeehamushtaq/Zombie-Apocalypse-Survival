class Resource < ApplicationRecord
    has_many :order_items
    has_one_attached :image

    validates :item_name, :points, presence: true
    validates :points, numericality: true
end
