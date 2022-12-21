# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :tutors, dependent: :destroy
  validates :course_name, presence: true
end
