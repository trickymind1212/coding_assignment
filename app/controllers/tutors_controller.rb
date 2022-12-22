# frozen_string_literal: true

class TutorsController < ApplicationController
  before_action :find_course

  def create
    tutor = @course.tutors.build(permit_tutor_params)
    response = if tutor.save
                 { message: t('success', entity: 'Tutor'), tutor_id: tutor.id }
               else
                 { message: t('failed', entity: 'tutor'), error_message: tutor.errors.full_messages.join(',') }
               end

    render json: response
  end

  private

  def find_course
    @course = Course.find_by(id: params[:course_id])
    if @course.blank?
      render json: { message: '', error_message: 'Invalid Course' }
      nil
    end
  end

  def permit_tutor_params
    params.permit(:name, :course_id)
  end
end
