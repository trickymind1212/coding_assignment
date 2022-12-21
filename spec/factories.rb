# frozen_string_literal: true

FactoryBot.define do
  factory :course, class: Course do
    course_name { 'test-course' }
  end

  factory :tutor, class: Tutor do
    tutor_name { 'test-tutor' }
    course
  end
end
