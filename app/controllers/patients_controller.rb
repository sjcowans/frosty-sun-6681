class PatientsController < ApplicationController
  def index
    @patients = Patient.alphabetical_adults
  end
end