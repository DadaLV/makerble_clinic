class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_doctor_role, only: [:dashboard]

  def index
    @doctors = User.where(role: 'doctor')
  end

  def show
  end

  def new
    @doctor = User.new
    @specializations = Specialization.all
  end

  def edit
    @specializations = Specialization.all
  end

  def create
    @doctor = User.new(doctor_params)
    @doctor.role = 'doctor'
    
    if @doctor.save
      redirect_to doctors_path, notice: 'Doctor was successfully created.'
    else
      @specializations = Specialization.all
      render :new
    end
  end

  def update
    if @doctor.update(doctor_params)
      redirect_to doctors_path, notice: 'Doctor was successfully updated.'
    else
      @specializations = Specialization.all
      render :edit
    end
  end

  def destroy
    @doctor.destroy
    redirect_to doctors_url, notice: 'Doctor was successfully destroyed.'
  end

  def dashboard
    @appointments_by_date = current_user.doctor_appointments.group_by_day(:date).count
    @appointments = current_user.doctor_appointments.order(date: :desc)
  end

  private
    def set_doctor
      @doctor = User.find(params[:id])
    end

    def doctor_params
      params.require(:user).permit(:first_name, :last_name, :contact_number, :specialization_id, :email, :password)
    end

    def check_doctor_role
      redirect_to root_path, alert: 'You are not authorized.' unless current_user.doctor?
    end
end
