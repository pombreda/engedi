class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def importer
  end

  def import
    file = params[:file]
    if ['.xls', '.xlsx'].include? File.extname(file.original_filename)
      course_groups = CourseGroup.all.to_a

      wb = open_spreadsheet file
      wb.default_sheet = wb.sheets.third
      6.upto wb.last_row do |row|
        code = wb.row(row)[1]
        name = wb.row(row)[2]
        if code.present? and name.present?
          begin
            Course.create({code: code, name: name, occurrence: 3, duration: 1.0, course_group_id: course_groups.sample.id})
          rescue StandardError => e
            puts e
          end
        end
      end

      success_message 'Courses imported successfully'
    else
      error_message 'Invalid file type. Please upload a .xls or .xlsx file type'
    end

    redirect_to courses_path
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params[:course]
  end

end
