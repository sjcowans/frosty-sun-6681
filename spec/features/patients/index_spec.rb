require 'rails_helper'

RSpec.describe 'patients index page' do
  before(:each) do
    @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
    @hospital_2 = Hospital.create!(name: "Seattle Grace Hospital")
    @doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Geisel School of Medicine")
    @doctor_2 = @hospital_2.doctors.create!(name: "Cristina Yang", specialty: "Cardiothoracic Surgery", university: "UC Berkeley")
    @patient_1 = Patient.create!(name: "Sean", age: 25)
    @patient_2 = Patient.create!(name: "John", age: 25)
    @patient_3 = Patient.create!(name: "Jacob", age: 25)
    @patient_4 = Patient.create!(name: "Jingleheimer", age: 25)
    @patient_5 = Patient.create!(name: "Schmidt", age: 25)
    @patient_6 = Patient.create!(name: "His Name Is My Name Too", age: 17)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_3.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_4.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_5.id)

    visit '/patients'
  end

  it 'lists only patients over 18' do
    expect(page).to have_content(@patient_1.name)
    expect(page).to have_content(@patient_2.name)
    expect(page).to have_content(@patient_3.name)
    expect(page).to have_content(@patient_4.name)
    expect(page).to have_content(@patient_5.name)
    expect(page).to have_no_content(@patient_6.name)
  end

  it 'displays name in alphabetical order' do
    expect(@patient_3.name).to appear_before(@patient_4.name)
    expect(@patient_4.name).to appear_before(@patient_2.name)
    expect(@patient_2.name).to appear_before(@patient_5.name)
    expect(@patient_5.name).to appear_before(@patient_1.name)
  end
end
