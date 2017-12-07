class User < ApplicationRecord

  validates :first_name, :last_name, :age, presence: true


  has_many :posts


  def name
    "#{first_name} #{last_name}"
  end
end
