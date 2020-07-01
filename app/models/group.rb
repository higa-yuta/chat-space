class Group < ApplicationRecord
  
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages
  
  validates :name, 
            presence: true,
            length: { maximum: 10 },
            format: { with: /\A[a-z0-9]+\z/i }
end 