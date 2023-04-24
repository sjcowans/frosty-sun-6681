require 'rails_helper'

RSpec.describe 'hospital show page' do
  before(:each) do
    @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
    @hospital_2 = Hospital.create!(name: "Seattle Grace Hospital")
    @doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Geisel School of Medicine")
    @doctor_2 = @hospital_1.doctors.create!(name: "Cristina Yang", specialty: "Cardiothoracic Surgery", university: "UC Berkeley")
    @doctor_3 = @hospital_1.doctors.create!(name: "Alex Karev", specialty: "Pediatric Surgery", university: "Johns Hopkins University")
    @doctor_4 = @hospital_1.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford")
    @doctor_5 = @hospital_2.doctors.create!(name: "McDreamy", specialty: "Attending Surgeon", university: "University of Pennsylvania")
    @doctor_6 = @hospital_2.doctors.create!(name: "Snips A Lot", specialty: "Failed Surgery", university: "University of Wikipedia")
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
    DoctorPatient.create!(doctor_id: @doctor_2.id, patient_id: @patient_6.id)
    DoctorPatient.create!(doctor_id: @doctor_1.id, patient_id: @patient_6.id)
    DoctorPatient.create!(doctor_id: @doctor_4.id, patient_id: @patient_6.id)
    DoctorPatient.create!(doctor_id: @doctor_5.id, patient_id: @patient_6.id)
    DoctorPatient.create!(doctor_id: @doctor_6.id, patient_id: @patient_6.id)
    DoctorPatient.create!(doctor_id: @doctor_3.id, patient_id: @patient_5.id)
    DoctorPatient.create!(doctor_id: @doctor_4.id, patient_id: @patient_5.id)
    DoctorPatient.create!(doctor_id: @doctor_5.id, patient_id: @patient_5.id)
    DoctorPatient.create!(doctor_id: @doctor_6.id, patient_id: @patient_5.id)
    DoctorPatient.create!(doctor_id: @doctor_6.id, patient_id: @patient_4.id)
    DoctorPatient.create!(doctor_id: @doctor_5.id, patient_id: @patient_4.id)
    DoctorPatient.create!(doctor_id: @doctor_5.id, patient_id: @patient_3.id)
    DoctorPatient.create!(doctor_id: @doctor_5.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_6.id, patient_id: @patient_3.id)
    DoctorPatient.create!(doctor_id: @doctor_6.id, patient_id: @patient_2.id)
    DoctorPatient.create!(doctor_id: @doctor_6.id, patient_id: @patient_1.id)
  end

  it 'lists hospital name and all doctors from this hospital' do
    visit "hospitals/#{@hospital_1.id}"

    expect(page).to have_content(@hospital_1.name)
    expect(page).to have_no_content(@hospital_2.name)

    within "#doctors" do
      expect(page).to have_content(@doctor_1.name)
      expect(page).to have_content(@doctor_2.name)
      expect(page).to have_content(@doctor_3.name)
      expect(page).to have_content(@doctor_4.name)
      expect(page).to have_no_content(@doctor_5.name)
      expect(page).to have_no_content(@doctor_6.name)
    end
  end

  it 'shows number of patients next to each doctor' do
    visit "hospitals/#{@hospital_1.id}"
    within "#doctor_#{@doctor_1.id}" do
      expect(page).to have_content("Patients: 4")
    end
    within "#doctor_#{@doctor_2.id}" do
      expect(page).to have_content("Patients: 3")
    end
    within "#doctor_#{@doctor_3.id}" do
      expect(page).to have_content("Patients: 1")
    end
    within "#doctor_#{@doctor_4.id}" do
      expect(page).to have_content("Patients: 2")
    end
  end

  it 'lists doctors in order of patients from most to least' do
    visit "hospitals/#{@hospital_1.id}"
    within "#doctors" do
      expect(@doctor_1.name.to_s).to appear_before(@doctor_2.name.to_s)
      expect(@doctor_2.name.to_s).to appear_before(@doctor_4.name.to_s)
      expect(@doctor_4.name.to_s).to appear_before(@doctor_3.name.to_s)
    end
  end
end
