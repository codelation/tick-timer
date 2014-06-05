class MainMenu < MenuMotion::Menu
  include BW::KVO
  include ProjectRows
  include SessionActions
  include TimerRows

  def init
    build_menu
    setup_observers
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
      Tick::Project.list do |projects|
        self.projects = projects
        build_logged_in_menu
      end
    else
      build_logged_out_menu
    end
  end

  def setup_observers
    observe(Tick::Timer, :timers) do |old_value, new_value|
      build_menu
    end
  end

end
