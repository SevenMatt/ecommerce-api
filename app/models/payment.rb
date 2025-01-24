class Payment < ApplicationRecord
    belongs_to :order
    
    validates :order_id, :stripe_charge_id, :amount, :status, presence: true
end