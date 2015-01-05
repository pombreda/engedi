class LecturersController < ApplicationController
  before_action :set_lecturer, only: [:show, :edit, :update, :destroy]

  def index
    @lecturers = Lecturer.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @lecturer = Lecturer.new(lecturer_params)

    respond_to do |format|
      if @lecturer.save
        format.html { redirect_to @lecturer, notice: 'Lecturer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lecturer }
      else
        format.html { render action: 'new' }
        format.json { render json: @lecturer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lecturer.update(lecturer_params)
        format.html { redirect_to @lecturer, notice: 'Lecturer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lecturer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lecturer.destroy
    respond_to do |format|
      format.html { redirect_to lecturers_url }
      format.json { head :no_content }
    end
  end

  def importer
  end

  def import
    file = params[:file]
    if ['.xls', '.xlsx'].include? File.extname(file.original_filename)
      wb = open_spreadsheet file
      wb.default_sheet = wb.sheets.second
      6.upto wb.last_row do |row|
        unless row == 42
          name = wb.row(row)[1]
          code = wb.row(row)[2]
          dept = wb.row(row)[3]
          if code.present? and name.present?
            begin
              Lecturer.create({code: code, name: name, department: dept})
            rescue StandardError => e
              puts e
            end
          end
        end
      end

      success_message 'Lecturers imported successfully'
    else
      error_message 'Invalid file type. Please upload a .xls or .xlsx file type'
    end

    redirect_to lecturers_path
  end

  def random
    courses = Course.all
    lecturers = Lecturer.all.to_a
    courses.each do |c|
      c.lecturer = lecturers.sample
      c.save
    end

    redirect_to lecturers_path
  end

  private

  def set_lecturer
    @lecturer = Lecturer.find(params[:id])
  end

  def lecturer_params
    params[:lecturer]
  end
end
