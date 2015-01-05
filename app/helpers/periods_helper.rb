module PeriodsHelper

  def get_period(day_index, slot_index)
    period = Period.where('day_index = ? and slot_index = ?', day_index, slot_index)
    unless period.present?
      period = Period.create({day_index:day_index, slot_index:slot_index})
    end

    period
  end

end
