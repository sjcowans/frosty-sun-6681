# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
@hospital_2 = Hospital.create!(name: "Seattle Grace Hospital")
@doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Geisel School of Medicine")
@doctor_2 = @hospital_2.doctors.create!(name: "Cristina Yang", specialty: "Cardiothoracic Surgery", university: "UC Berkeley")
@patient_1 = Patient.create!(name: "Sean", age: 25)
@patient_2 = Patient.create!(name: "John", age: 25)
@patient_3 = Patient.create!(name: "Jacob", age: 25)
@patient_4 = Patient.create!(name: "Jingleheimer", age: 25)
@patient_5 = Patient.create!(name: "Schmidt", age: 25)
DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_3.id)
DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_4.id)
DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_5.id)