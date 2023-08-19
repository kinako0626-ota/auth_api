class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { maximum: 255 }
    validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: true,
            format: {
              allow_blank: true,
              with: /\A[\w+\-.]+@[a-z\d\-_]+(\.[a-z\d\-_]+)*\.[a-z]+\z/i,
              message: :invalid,
            }
end
