class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authorized_role, only: [:new, :create, :edit, :update, :destroy]

  def index
    @patients = User.where(role: 'patient').order(created_at: :desc)
  end

  def show
    @patient = User.find(params[:id])
  end

  def new
    @patient = User.new
  end

  def create
    @patient = User.new(patient_params)
    @patient.role = 'patient'
    
    if @patient.save
      redirect_to root_path, notice: 'Patient was successfully created.'
    else
      render :new
    end
  end

  def edit
    @patient = User.find(params[:id])
  end
  
  def update
    @patient = User.find(params[:id])
    
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @patient = User.find(params[:id])
    @patient.destroy
    redirect_to patients_url, notice: 'Patient was successfully destroyed.'
  end
  
  private
  
  def patient_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :contact_number, :address, :age, :medical_history)
  end
  
  def check_authorized_role
    redirect_to root_path, alert: 'You are not authorized.' unless current_user.receptionist?
  end
end
