class MainMenu < NSMenu
  attr_reader :about_menu_item, :login_menu_item, :logout_menu_item, 
              :quit_menu_item, :running_timer_menu_items, :start_timer_menu_item

  def build_menu
    self.removeAllItems
  
    @app_name = NSBundle.mainBundle.infoDictionary["CFBundleDisplayName"]
  
    if Tick.logged_in?
      # Project - Task - 00:00 >
      add_running_timer_menu_items
      # Start Timer >
      self.addItem(start_timer_menu_item)
    else
      # Log In
      self.addItem(login_menu_item)
    end
  
    # ----------
    self.addItem(NSMenuItem.separatorItem)
  
    # About Timer for Tick
    self.addItem(about_menu_item)
  
    if Tick.logged_in?
      # Log Out
      self.addItem(logout_menu_item)
    end
  
    # Quit
    self.addItem(quit_menu_item)
  end

  def about_menu_item
    @about_menu_item ||= NSMenuItem.alloc.initWithTitle("About #{@app_name}", action:"orderFrontStandardAboutPanel:", keyEquivalent:"")
  end

  def login_menu_item
    @login_menu_item ||= begin
      login_menu_item = NSMenuItem.alloc.initWithTitle("Log In", action:"show_login_window", keyEquivalent:"")
      login_menu_item.target = self
      login_menu_item
    end
  end

  def logout_menu_item
    @logout_menu_item ||= begin
      logout_menu_item = NSMenuItem.alloc.initWithTitle("Log Out", action:"log_out", keyEquivalent:"")
      logout_menu_item.target = Tick
      logout_menu_item
    end
  end

  def quit_menu_item
    @quit_menu_item ||= NSMenuItem.alloc.initWithTitle("Quit", action:"terminate:", keyEquivalent:"")
  end

  def running_timer_menu_items
    started_timers = Tick::Timer.list
    started_timers.sort_by{|timer|
      [timer.task.project.name, timer.task.name]
    }.map{|timer|
      Timer::MenuItem.alloc.initWithTimer(timer)
    }
  end

  def show_login_window
  
  end

  def start_timer_menu_item
    @start_timer_menu_item ||= StartTimer::MenuItem.alloc.initWithTitle("Start Timer", action:nil, keyEquivalent:"")
  end

private

  def add_running_timer_menu_items
    running_timer_menu_items.each do |menu_item|
      self.addItem(menu_item)
    end
  end

end