require 'rails_helper'

RSpec.describe Patient do
  it {should have_many :doctor_patients}
  it {should have_many(:doctors).through(:doctor_patients)}

  it 'can list adults in alphabetical order' do
    @patient_1 = Patient.create!(name: "Sean", age: 25)
    @patient_2 = Patient.create!(name: "John", age: 25)
    @patient_3 = Patient.create!(name: "Jacob", age: 25)
    @patient_4 = Patient.create!(name: "Jingleheimer", age: 25)
    @patient_5 = Patient.create!(name: "Schmidt", age: 25)
    @patient_6 = Patient.create!(name: "His Name Is My Name Too", age: 17)

    expect(Patient.alphabetical_adults).to eq([@patient_3, @patient_4, @patient_2, @patient_5, @patient_1])
  end
end
