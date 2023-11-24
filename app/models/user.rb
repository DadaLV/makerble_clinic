class User < ApplicationRecord

  enum role: { receptionist: 'receptionist', doctor: 'doctor' }
   
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :role, presence: true
end
