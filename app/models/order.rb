class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  enum status: { cart: 'cart', completed: 'completed' }

  # Calcular o total do pedido
  def total_price
    order_items.joins(:product).sum('order_items.quantity * products.price')
  end

  validates :email, presence: true, format: { with> URI::MailTo::EMAIL_REGEXP }
  validates :customer_name, presence: true
end
end

  
