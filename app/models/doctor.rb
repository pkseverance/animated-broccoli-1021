class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  def remove_patient(patient_params)
    self.patients.destroy(patient_params)
  end
end
