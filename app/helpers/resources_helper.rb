module ResourcesHelper

  def synchronise(file)
    wb = open_spreadsheet file

    import_courses wb
    import_lecturers wb
    import_rooms wb

    create_course_sections wb
    set_period_allocations wb
  end

  def import_courses(wb)
    wb.default_sheet = wb.sheets.third
    6.upto wb.last_row do |row|
      code = wb.row(row)[1]
      name = wb.row(row)[2]
      if code.present? and name.present?
        begin
          Course.create({code: code, name: name})
        rescue StandardError => e
          puts e
        end
      end
    end
  end

  def import_lecturers(wb)
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
  end

  def import_rooms(file)
  end

  def create_course_sections(wb)
    wb.default_sheet = wb.sheets[5]
    14.upto wb.last_row do |row|
      begin
        course = Course.where('name=?', wb.row(row)[1]).take!
        2.upto 8 do |col|
          set = wb.row(row)[col]
          unless set.strip.casecmp('none').zero?
            set.strip!
            level = col + 5
            set.split(',').each do |s|
              section = Section.find_or_create(col+5, s.strip)
              section.level_designation = get_level_designation(col+5)
              section.save

              cs = CourseSection.new
              cs.course = course
              cs.section = section
              cs.save
            end
          end
        end
      rescue StandardError => e
        puts e
      end
    end
  end

  def set_period_allocations(wb)
    wb.default_sheet = wb.sheets[4]
    5.upto wb.last_row do |row|
      begin
        course = Course.where('name=?', wb.row(row)[1]).take!
        2.upto 8 do |col|
          level = col+5
          course_sections = CourseSection.joins(:section).where('level=? and course_id=?', level, course.id)
          course_sections.each do |cs|
            cs.periods = wb.row(row)[col]
            cs.save
          end
        end
      rescue StandardError => e
        puts e
      end
    end
  end

  private

  def get_level_designation(level)
    case level
      when 7 then
        'F1'
      when 8 then
        'F2'
      when 9 then
        'F3'
      when 10 then
        'F4'
      when 11 then
        'F5'
      when 12 then
        'L6'
      when 13 then
        'U6'
      else
    end
  end

end
