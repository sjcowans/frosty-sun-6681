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
end
