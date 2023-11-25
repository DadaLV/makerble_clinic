class SpecializationsController < ApplicationController
  before_action :set_specialization, only: [:show, :edit, :update, :destroy]

  def index
    @specializations = Specialization.all
  end

  def show
  end

  def new
    @specialization = Specialization.new
  end

  def create
    @specialization = Specialization.new(specialization_params)
    if @specialization.save
      redirect_to @specialization, notice: 'Specialization was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @specialization.update(specialization_params)
      redirect_to @specialization, notice: 'Specialization was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @specialization.destroy
    redirect_to specializations_url, notice: 'Specialization was successfully destroyed.'
  end

  private
    def set_specialization
      @specialization = Specialization.find(params[:id])
    end

    def specialization_params
      params.require(:specialization).permit(:name, :description)
    end
end
