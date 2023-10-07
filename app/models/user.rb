class User < ApplicationRecord
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  phone_regex = /\A\(\d{2}\)\s\d{4,5}-\d{4}\z/
  cpf_regex = /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/

  validates :email, presence: true, format: { with: email_regex}
  validates :cpf, presence: true, format: { with: cpf_regex, message: "is invalid, Ex: 123.456.789-00" }
  validates :phone, presence: true, format: { with: phone_regex, message: "is invalid, Ex: (00) 0000-0000"  }
end
