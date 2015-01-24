class CourseSectionsController < ApplicationController
  before_action :set_course_section, only: [:show, :edit, :update, :destroy]

  def index
    @course_sections = CourseSection.all
  end

  def show
  end

  def new
    @course_section = CourseSection.new
  end

  def edit
  end

  def create
    @course_section = CourseSection.new(course_section_params)

    respond_to do |format|
      if @course_section.save
        format.html { redirect_to @course_section, notice: 'Course section was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course_section }
      else
        format.html { render action: 'new' }
        format.json { render json: @course_section.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course_section.update(course_section_params)
        format.html { redirect_to @course_section, notice: 'Course section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course_section.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course_section.destroy
    respond_to do |format|
      format.html { redirect_to course_sections_url }
      format.json { head :no_content }
    end
  end

  private

  def set_course_section
    @course_section = CourseSection.find(params[:id])
  end

  def course_section_params
    params[:course_section]
  end
end
