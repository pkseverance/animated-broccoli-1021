require 'rails_helper'

RSpec.describe Patient do
    it {should have_many(:doctors).through(:doctor_patients)}

    describe '#adult' do
        before(:each) do
            DoctorPatient.destroy_all
            Doctor.destroy_all
            Hospital.destroy_all
            Patient.destroy_all
            @hospital_1 = Hospital.create!(name: 'Seattle Grace')
            @hospital_2 = Hospital.create!(name: 'St. Jude')
            @doctor_1 = @hospital_1.doctors.create!(name: 'Dr. Smith', specialty: 'Neurosurgeon', university: 'Harvard Medical School')
            @doctor_2 = @hospital_2.doctors.create!(name: 'Dr. Brown', specialty: 'Endocrinologist', university: "Johns Hopkins")
            @patient_1 = @doctor_1.patients.create!(name: 'Judy Whitkins', age: 82 )
            @patient_2 = @doctor_1.patients.create!(name: 'James Whitkins', age: 74 )
            @patient_3 = @doctor_2.patients.create!(name: 'Lillian Baker', age: 16 )
            @patient_4 = @doctor_1.patients.create!(name: 'Sally Whatkins', age: 8)
        end

        it 'returns all patients over 18' do
            expect(Patient.adult).to eq([@patient_1, @patient_2])
            expect(Patient.adult).to_not eq([@patient_3, @patient_4])
        end
    end
end