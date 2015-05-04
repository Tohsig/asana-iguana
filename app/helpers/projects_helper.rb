module ProjectsHelper
  def set_week(week_type: false, date_type: false, start_date: false)
    case week_type
    when :prev
      case date_type
      when :start
        start_date - start_date.wday - 7
      when :end
        start_date - start_date.wday - 1
      end
    when :this
      case date_type
      when :start
        Date.today - Date.today.wday
      when :end
        Date.today - Date.today.wday + 6
      end
    when :next
      case date_type
      when :start
        start_date - start_date.wday + 7
      when :end
        start_date - start_date.wday + 13
      end
    else
      false
    end
  end

  def button_text(type)
    case type
    when :prev
      "< Week"
    when :this
      "Current Week"
    when :next
      "Week >"
    else
      false
    end
  end
end
