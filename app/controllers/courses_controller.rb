# frozen_string_literal: true

class CoursesController < ApplicationController
  def create
    course = Course.new(permit_course_params)
    response = if course.save
                 { message: t('success', entity: 'Course'), data: course.id }
               else
                 { message: t('failed', entity: 'course'), error_message: course.errors.full_messages.join(',') }
               end

    render json: response
  end

  def list
    permitted_params = permit_course_params
    page = permitted_params[:page]&.to_i
    per_page = permitted_params[:per_page]&.to_i
    courses = []
    total_courses = Course.count
    Course.limit(per_page).offset(page).includes(:tutors).map do |course|
      course_details = course.as_json(except: %i[created_at updated_at])
      course_details[:tutors] = course.tutors.as_json(except: %i[course_id updated_at created_at])
      courses << course_details
    end

    render json: {
      message: t('course_list_success'),
      data: courses,
      total_courses: total_courses,
      page: page,
      per_page: per_page
    }
  end

  private

  def permit_course_params
    case params[:action]
    when 'create'
      params.permit(:course_name)
    when 'list'
      params.permit(:page, :per_page)
    end
  end
end
