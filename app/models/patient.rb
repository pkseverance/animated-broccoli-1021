class Patient < ApplicationRecord
    has_many :doctor_patients
    has_many :doctors, through: :doctor_patients

    def self.adult
        self.all.where('age > 18')
    end
end