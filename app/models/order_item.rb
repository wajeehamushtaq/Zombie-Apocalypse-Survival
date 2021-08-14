class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :resource
    before_save :set_unit_price
    before_save :set_total

    validates :quantity, :total, :unit_price, presence: true
    validates :quantity, :total, :unit_price, numericality: true

    def unit_price
        if persisted?
            self[:unit_price]
        else
            resource.points
        end
    end


    def total
        unit_price*quantity
    end


    private

    def set_unit_price
        self[:unit_price] = unit_price 
    end

    def set_total
        self[:total] = total * quantity
    end
end
