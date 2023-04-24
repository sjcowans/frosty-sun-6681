class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
  end

  def destroy
    if !params[:patient_id].nil?
      doctor = Doctor.find(params[:id])
      doctor.patients.delete(params[:patient_id])
      redirect_to "/doctors/#{doctor.id}"
    else
    end
  end
end