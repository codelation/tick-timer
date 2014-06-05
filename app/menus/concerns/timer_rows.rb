module TimerRows

  def clear_timer(menu_item)
    timer = menu_item.object
    timer.clear
  end

  def timer_rows
    Tick::Timer.list.map{|timer|
      title = timer.task.project.name + " - "
      title += timer.task.name + " - "
      title += timer.paused? ? "Paused" : timer.displayed_time
      {
        title: title,
        sections: [{
          rows: [{
            title: timer.paused? ? "Resume" : "Pause",
            target: self,
            action: "toggle_timer:",
            object: timer,
            type: :timer
          }, {
            title: "Clear",
            target: self,
            action: "clear_timer:",
            object: timer,
            type: :timer
          }]
        }, {
          rows: [{
            title: "Submit",
            target: self,
            action: "submit_timer:",
            object: timer,
            type: :timer
          }]
        }]
      }
    }
  end

  def submit_timer(menu_item)
    timer = menu_item.object
    timer.submit!
  end

  def toggle_timer(menu_item)
    timer = menu_item.object
    if timer.is_running
      timer.stop
    else
      timer.start
    end
    # TODO: Use KVO for monitoring timer running/paused
    build_menu
  end

end
