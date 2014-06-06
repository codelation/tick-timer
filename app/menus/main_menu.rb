class MainMenu < MenuMotion::Menu
  include ProjectRows
  include SessionActions
  include TimerRows

  def init
    start_update_timer
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
          action: "log_in"
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
      if self.projects
        build_logged_in_menu
      else
        Tick::Project.list do |projects|
          self.projects = projects.select{|project|
            !project.closed_on
          }.sort_by{|project|
            project.name.downcase
          }
          build_logged_in_menu
        end
      end
    else
      build_logged_out_menu
    end
    NSApplication.sharedApplication.delegate.update_status_item
  end

  def start_update_timer
    @update_timer = NSTimer.scheduledTimerWithTimeInterval(10, target:self, selector: "build_menu", userInfo: nil, repeats: true)
    @update_timer.setTolerance(10)
    @update_timer.fire
  end

end
