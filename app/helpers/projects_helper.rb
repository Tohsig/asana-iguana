module ProjectsHelper
  def set_week(type: false, start_date: false, end_date: false)
    case type
    when :prev
      if start_date
        start_date - start_date.wday - 7
      elsif end_date
        end_date - end_date.wday - 1
      end
    when :this
      if start_date
        Date.today - Date.today.wday
      elsif end_date
        Date.today - Date.today.wday + 6
      end
    when :next
      if start_date
        start_date - start_date.wday + 7
      elsif end_date
        end_date - end_date.wday + 13
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
