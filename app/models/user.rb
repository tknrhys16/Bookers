class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: {maximum: 50}
  attachment :profile_image
  validates :name,    length: { minimum: 2 }
  validates :name,    length: { maximum: 20 }
  validates :introduction,    length: { maximum: 50 }

  #validates :email, uniqueness: true
  #validates :name, uniqueness: true

  #belongs_to :book
  has_many :books, dependent: :destroy

  validates :email, uniqueness: true
  validates :name, uniqueness: true
end
