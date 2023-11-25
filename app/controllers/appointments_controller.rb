class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = Appointment.all
  end

  def show
  end

  def new
    @appointment = Appointment.new
    @doctors = User.where(role: 'doctor')
    @patients = User.where(role: 'patient')
  end

  def edit
    @doctors = User.where(role: 'doctor')
    @patients = User.where(role: 'patient')
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to @appointment, notice: 'Appointment was successfully created.'
    else
      @doctors = User.where(role: 'doctor')
      @patients = User.where(role: 'patient')
      render :new
    end
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: 'Appointment was successfully updated.'
    else
      @doctors = User.where(role: 'doctor')
      @patients = User.where(role: 'patient')
      render :edit
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_url, notice: 'Appointment was successfully destroyed.'
  end

  private
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:patient_id, :doctor_id, :date, :notes)
    end
end
