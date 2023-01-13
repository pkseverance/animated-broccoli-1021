class DoctorsController < ApplicationController
    def show
        @doctor = Doctor.find(params[:id])
    end
    
    def destroy
        @doctor = Doctor.find(params[:id])
        @doctor.remove_patient(params[:patient_id])
        redirect_to "/doctors/#{@doctor.id}"
    end
end