require 'rails_helper'

# User Story 3, Patient Index Page
# ​
# As a visitor
# When I visit the patient index page
# I see the names of all adult patients (age is greater than 18),
# And I see the names are in ascending alphabetical order (A - Z, you do not need to account for capitalization)

RSpec.describe 'Patients index' do
    describe 'When I visit the patient index page' do
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
            @patient_2 = @doctor_1.patients.create!(name: 'Andrew Schmidt', age: 34 )
            @patient_3 = @doctor_2.patients.create!(name: 'Lillian Baker', age: 16 )
            @patient_4 = @doctor_2.patients.create!(name: 'Sam McMillen', age: 42 )
            @patient_5 = @doctor_1.patients.create!(name: 'Sally Whatkins', age: 8)

            @doctor_2.patients << @patient_1

        end

        it 'has the names of all adult patients in ascending alphabetical order' do
            visit '/patients'

            expect(page).to have_content(@patient_1.name)
            expect(page).to have_content(@patient_2.name)
            expect(page).to have_content(@patient_4.name)

            expect(page).to_not have_content(@patient_3.name)
            expect(page).to_not have_content(@patient_5.name)

            expect(@patient_2.name).to appear_before(@patient_1.name)
            expect(@patient_2.name).to appear_before(@patient_4.name)
            expect(@patient_1.name).to appear_before(@patient_4.name)
        end
    end
end