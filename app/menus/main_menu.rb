class MainMenu < MenuMotion::Menu
  attr_accessor :projects

  def init
    build_menu
    self
  end

  def build_logged_in_menu
    sections = []

    # Build the rows for running timers
    unless timer_rows.empty?
      sections << {
        rows: timer_rows
      }
    end

    # Build row for Start Timer submenu
    sections << {
      rows: [{
        title: "Start Timer",
        rows: project_rows
      }]
    }

    # Build action rows
    sections << {
      rows: [{
        title: "About Timer for Tick",
        action: "orderFrontStandardAboutPanel:"
      }, {
        title: "Log Out",
        target: self,
        action: "log_out"
      }, {
        title: "Quit",
        action: "terminate:"
      }]
    }

    # Finally, build out the menu
    build_menu_from_params(self, { sections: sections })
  end

  def build_logged_out_menu
    params = {
      sections: [{
        rows: [{
          title: "Log In",
          target: self,
          action: "show_login_window"
        }]
      }, {
        rows: [{
          title: "About Timer for Tick",
          action: "orderFrontStandardAboutPanel:"
        }, {
          title: "Quit",
          action: "terminate:"
        }]
      }]
    }
    build_menu_from_params(self, params)
  end

  def build_menu
    self.removeAllItems
    if Tick.logged_in?
      Tick::Project.list do |projects|
        self.projects = projects
        build_logged_in_menu
      end
    else
      build_logged_out_menu
    end
  end

  def log_out
    Tick.log_out
    build_menu
  end

  def project_rows
    self.projects.map{|project|
      {
        title: project.name,
        rows: project.tasks.map{|task|
          {
            title: task.name,
            object: task,
            tag: "task_#{task.id}",
            target: self,
            action: "start_timer:"
          }
        }
      }
    }
  end

  def show_login_window
    @login_window = LoginWindow.alloc.initWithContentRect([[0, 0], [300, 180]],
                      styleMask: NSTitledWindowMask|NSClosableWindowMask,
                      backing: NSBackingStoreBuffered,
                      defer: false)
  end

  def start_timer(menu_item)
    task = menu_item.object

    ap "Start Timer: #{task.project.name}"

    timer = Tick::Timer.start_with_task(task)
    build_menu
  end

  def timer_rows
    Tick::Timer.list.map{|timer|
      title = timer.task.project.name + " - "
      title += timer.task.name + " - "
      title += timer.paused? ? "Paused" : timer.displayed_time
      {
        title: title,
        rows: [{
          title: timer.paused? ? "Pause" : "Resume"
        }, {
          title: "Submit"
        }]
      }
    }
  end

end
