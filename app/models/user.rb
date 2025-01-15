class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :validatable

    enum role: { admin: 'admin', customer: 'customer'}


    # Validações para o email
    validates :email, presence: true, uniqueness: true, format: { with: URI::Mailto::EMAIL_REGEXP, message: "invalid email format" }

    # validação para a senha
    validates :password, presence: true, length: { minimum: 6}, on: :create

    # Usando bcrypt para criptografar a senha
    has_secure_password

    # Método para gerar o token JWT
    def generate_jwt
        payload = { user_id: self.id}
        JWT.encode(payload, Rails:application.secrets.secret_key_base, 'HS256')
    end
end