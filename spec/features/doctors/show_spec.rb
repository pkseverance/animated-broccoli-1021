require 'rails_helper'
# User Story 1, Doctors Show Page
#
# # As a visitor
# # When I visit a doctor's show page
# # I see all of that doctor's information including:
# #  - name
# #  - specialty
# #  - university where they got their doctorate
# # And I see the name of the hospital where this doctor works
# # And I see the names of all of the patients this doctor has

# User Story 2, Remove a Patient from a Doctor
# ​
# As a visitor
# When I visit a Doctor's show page
# Then next to each patient's name, I see a button to remove that patient from that doctor's caseload
# When I click that button for one patient
# I'm brought back to the Doctor's show page
# And I no longer see that patient's name listed
# And when I visit a different doctor's show page that is caring for the same patient,
# Then I see that the patient is still on the other doctor's caseload

RSpec.describe "Doctor's show page" do
    describe "When I visit a doctor's show page" do
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

        it 'has the name, specialty, and university of each doctor' do
            visit "/doctors/#{@doctor_1.id}"

            expect(page).to have_content(@doctor_1.name)
            expect(page).to have_content(@doctor_1.university)
            expect(page).to have_content(@doctor_1.specialty)

            visit "/doctors/#{@doctor_2.id}"

            expect(page).to have_content(@doctor_2.name)
            expect(page).to have_content(@doctor_2.university)
            expect(page).to have_content(@doctor_2.specialty)
        end

        it 'has the name of the hospital this doctor works at' do
            visit "/doctors/#{@doctor_1.id}"

            expect(page).to have_content(@doctor_1.hospital.name)

            visit "/doctors/#{@doctor_2.id}"

            expect(page).to have_content(@doctor_2.hospital.name)
        end

        it 'has the names of all the patients this doctor has' do
            visit "/doctors/#{@doctor_1.id}"

            expect(page).to have_content(@doctor_1.patients.first.name)
            expect(page).to have_content(@doctor_1.patients.last.name)

            visit "/doctors/#{@doctor_2.id}"

            expect(page).to have_content(@doctor_2.patients.first.name)
            expect(page).to have_content(@doctor_2.patients.last.name)
        end

        it 'has a button to remove a patient from a doctor next to each patient' do
            visit "/doctors/#{@doctor_1.id}"

            expect(page).to have_content(@doctor_1.patients.first.name)

            expect(page).to have_button("Remove #{@patient_1.name}")
            click_button("Remove #{@patient_1.name}")

            @doctor_1.reload

            expect(current_path).to eq("/doctors/#{@doctor_1.id}")
            expect(page).to_not have_content(@patient_1.name)
            expect(page).to have_content(@doctor_1.patients.first.name)

            visit "/doctors/#{@doctor_2.id}"

            expect(page).to have_content(@patient_1.name)
        end
    end
end