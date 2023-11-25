class User < ApplicationRecord
  belongs_to :specialization, optional: true
  has_many :doctor_appointments, class_name: 'Appointment', foreign_key: 'doctor_id'
  has_many :patient_appointments, class_name: 'Appointment', foreign_key: 'patient_id'

  enum role: { receptionist: 'receptionist', doctor: 'doctor', patient: 'patient', admin: 'admin' }
   
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :role, presence: true
    
  def full_name
    "#{first_name} #{last_name}"
  end

  def doctor?
    role == 'doctor'
  end

  def patient?
    role == 'patient'
  end
end
