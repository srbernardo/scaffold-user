class User < ApplicationRecord
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  phone_regex = /\A\(\d{2}\)\s\d{4,5}-\d{4}\z/
  cpf_regex = /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/

  validates :name, presence: true
  validates :email, presence: true, format: { with: email_regex}, uniqueness: true
  validates :cpf, presence: true, format: { with: cpf_regex, message: "is invalid, Ex: 123.456.789-00" }, uniqueness: true
  validates :phone, presence: true, format: { with: phone_regex, message: "is invalid, Ex: (00) 0000-0000"  }, uniqueness: true

  def self.search_by_all_fields(query)
    where("name LIKE :query OR cpf LIKE :query OR phone LIKE :query OR email LIKE :query", query: "%#{query}%")
  end
end
