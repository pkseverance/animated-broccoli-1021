class PatientsController < ApplicationController
    def index
        @patients = Patient.adult.order(:name)
    end
end