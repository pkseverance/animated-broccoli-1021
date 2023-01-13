require 'rails_helper'

RSpec.describe Doctor do
  it {should belong_to :hospital}
  it {should have_many(:patients).through(:doctor_patients)}

  describe '#remove_patient' do
    before(:each) do
      DoctorPatient.destroy_all
      Doctor.destroy_all
      Hospital.destroy_all
      Patient.destroy_all
      @hospital_1 = Hospital.create!(name: 'Seattle Grace')
      @doctor_1 = @hospital_1.doctors.create!(name: 'Dr. Smith', specialty: 'Neurosurgeon', university: 'Harvard Medical School')
      @patient_1 = @doctor_1.patients.create!(name: 'Judy Whitkins', age: 82 )
      @patient_2 = @doctor_1.patients.create!(name: 'James Whitkins', age: 74 )
    end

    it "removes a patient from a doctor's practice" do

      expect(@doctor_1.patients).to eq([@patient_1, @patient_2])
      @doctor_1.remove_patient(@patient_1.id)
      expect(@doctor_1.patients).to eq([@patient_2])
    end
  end
end
