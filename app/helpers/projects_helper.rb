module ProjectsHelper
  def next_week
  end

  def set_week(kind: false, start_date: false, end_date: false)
    case kind
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
end
