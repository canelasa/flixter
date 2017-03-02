class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show]

  def show
  end

  private

  def require_authorized_for_current_course
    if !current_user.enrolled_in?(current_course)
       redirect_to course_path(current_course), alert: 'You must be enrolled to view lesson details'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  helper_method :current_course
  def current_course
    @current_course ||= current_lesson.section.course
  end
end

# shorthand for:
#@current_course = @current_course || current_lession.section.course

# first time (before @current_course is ever set)
#@current_course = nil || current_lession.section.course

# second time (after @current_course is set)
#@current_course = @current_course # never gets to the other side of the ||
