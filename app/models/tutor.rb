# frozen_string_literal: true

class Tutor < ApplicationRecord
  belongs_to :course
  validates :tutor_name, presence: true
end
