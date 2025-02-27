require 'rails_helper'

RSpec.describe Doctor do
  it {should belong_to :hospital}
  it {should have_many :doctor_patients}
  it {should have_many(:patients).through(:doctor_patients)}

  it 'can list hospital name for doctor' do
    @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
    @hospital_2 = Hospital.create!(name: "Seattle Grace Hospital")
    @doctor_1 = @hospital_1.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Geisel School of Medicine")
    @doctor_2 = @hospital_2.doctors.create!(name: "Cristina Yang", specialty: "Cardiothoracic Surgery", university: "UC Berkeley")

    expect(@doctor_1.hospital_name).to eq("Grey Sloan Memorial Hospital")
    expect(@doctor_2.hospital_name).to eq("Seattle Grace Hospital")
  end

  it 'can list doctors by number of patients' do
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

    expect(Doctor.ordered_patient_count).to eq([@doctor_6, @doctor_5, @doctor_1, @doctor_2, @doctor_4, @doctor_3])
  end
end
