class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules = Schedule.all
  end

  def show
    @colors = {}
    @schedule.lectures.each do |l|
      @colors[l.course.id] = "%06x" % (rand * 0xffffff)
    end
  end

  def new
  end

  def edit
  end

  def create
    name = params[:schedule][:name]

    if name.present?
      s = Schedule.new
      s.name = name
      s.status = Schedule::STATUS_IN_PROGRESS
      s.save

      write_schedule_to_file s
      run_scheduler s

      Thread.new do
      end

      success_message 'Generating schedule. This will take several minutes. Please check back later'
      redirect_to schedules_path
    else
      error_message 'Failed to create schedule. Please make sure you have specified a name and have selected at least one course.'
      @courses = Course.all
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url }
      format.json { head :no_content }
    end
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id]) if params[:id].present?
  end

  def schedule_params
    params[:schedule]
  end

  def schedule_to_json(schedule)
    h = {schedule_id: schedule.id, courses: []}
    sections = CourseSection.joins(:section).where('section_id=19')
    sections.each do |s|
      h[:courses] << {
          code: s.course.code,
          section: s.section.id,
          lecturer: '',
          periods: s.periods
      }
    end
    h.to_json
  end

  def write_schedule_to_file(schedule)
    dir = Rails.root.join('schedules', "r#{Time.now.to_i.to_s}")
    Dir.mkdir dir, 0700
    IO.write(dir.join('in.json'), schedule_to_json(schedule))

    schedule.folder = dir.to_s
    schedule.save
  end

  def get_period(day_index, time_slot)
    period = Period.where('day_index = ? and time_slot = ?', day_index, time_slot).take
    unless period.present?
      period = Period.create({day_index: day_index, time_slot: time_slot})
    end

    period
  end

  def run_scheduler(schedule)
    `python #{Rails.root.join('lib', 'pyscheduler', 'scheduler.py')} #{schedule.folder}`
    list = JSON.parse(IO.read(schedule.folder + '/out.json'))

    for item in list
      course = Course.find_by_code item['code']
      for p in item['lectures']
        period = get_period p['dayIndex'], p['slotIndex']
        lecture = Lecture.new
        lecture.course = course
        lecture.schedule = schedule
        lecture.start_period = period
        lecture.end_period = period
        lecture.save
      end
    end

    schedule.status = Schedule::STATUS_COMPLETED
    schedule.save
  end
end
