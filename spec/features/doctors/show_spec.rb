require 'rails_helper'

RSpec.describe 'doctor show page' do
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
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_1.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_3.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_4.id)
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_5.id)
  end

  it 'has correct attributes' do
    visit "/doctors/#{@doctor_1.id}"

    expect(page).to have_content(@doctor_1.name)
    expect(page).to have_content(@doctor_1.specialty)
    expect(page).to have_content(@doctor_1.university)
  end

  it 'has name of hospital and patients' do
    visit "/doctors/#{@doctor_1.id}"

    expect(page).to have_content(@hospital_1.name)
    expect(page).to have_content(@patient_1.name)
    expect(page).to have_content(@patient_2.name)
    expect(page).to have_content(@patient_3.name)
    expect(page).to have_no_content(@hospital_2.name)
    expect(page).to have_no_content(@patient_4.name)
    expect(page).to have_no_content(@patient_5.name)
  end

  it 'can delete a patient from doctor' do
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_2.id)
    visit "/doctors/#{@doctor_1.id}"

    expect(page).to have_button("Delete")

    within "#patient_#{@patient_2.id}" do
      click_button "Delete"
    end

    expect(page).to have_no_content(@patient_2.name)
    expect(current_path).to eq("/doctors/#{@doctor_1.id}")

    visit "/doctors/#{@doctor_2.id}"
    expect(page).to have_content(@patient_2.name)
  end
end
