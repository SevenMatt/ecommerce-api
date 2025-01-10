class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :validatable

    enum role: { admin: 'admin', customer: 'customer'}
end