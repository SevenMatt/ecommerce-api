class Product < ApplicationRecord
    has_many :order_items
    has_many :reviews

    validates :name, :price, :stock, :gender, :presence: true

    # Escopo para filtrar por gênero
    scope :by_gender, ->(gender) { where(gender: gender) }

    # Retornar os mais vendidos
    def self.most_sold(limit = 10)
        joins(:order_items)
        .select('products.*, SUM(order_items.quantity) AS total_sold')
        .group('products.id')
        .order('total_sold DESC')
        .limit(limit)
    end
    
    belongs_to :category

    validates :name. presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
end
