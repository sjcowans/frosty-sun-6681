class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients

  def hospital_name
    hospital.name
  end

  def self.ordered_patient_count
    joins(:patients)
    .select("doctors.*, count(DISTINCT patients.id) as patient_count")
    .group("doctors.id")
    .order("patient_count DESC")
  end
end
