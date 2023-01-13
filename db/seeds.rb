# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
