class MainMenu < NSMenu
  attr_accessor :running_timer_item, :timer_menu
  
  def authentication_controller
    Tick::AuthenticationController.instance
  end
  
  def build_menu
    self.removeAllItems
    
    @app_name = NSBundle.mainBundle.infoDictionary["CFBundleDisplayName"]
    
    if authentication_controller.logged_in?
      if self.delegate.current_timer
        self.addItem(self.running_timer_item)
      else
        self.addItem(self.start_timer_item)
      end
    
      self.timer_menu.build_menu
    else
      login_item = NSMenuItem.alloc.initWithTitle("Log in", action:"show_login_window", keyEquivalent:"")
      login_item.target = self
      self.addItem(login_item)
    end
    
    self.addItem(NSMenuItem.separatorItem)
    
    @about_item = NSMenuItem.alloc.initWithTitle("About #{@app_name}", action:"orderFrontStandardAboutPanel:", keyEquivalent:"")
    self.addItem(@about_item)
    
    if authentication_controller.logged_in?
      @logout_item = NSMenuItem.alloc.initWithTitle("Log out", action:"logout", keyEquivalent:"")
      @logout_item.target = self
      self.addItem(@logout_item)
    end
    
    self.addItem(NSMenuItem.alloc.initWithTitle("Quit", action:"terminate:", keyEquivalent:""))
  end
  
  def login(company, email, password)
    authentication_controller.login(company, email, password).then(lambda{|result|
      self.build_menu
    })
  end
  
  def logout
    authentication_controller.logout
    self.build_menu
  end
  
  def running_timer_item
    @running_timer_item ||= begin
      item = NSMenuItem.alloc.initWithTitle("00:00", action:nil, keyEquivalent:"")
      item.setSubmenu(self.timer_menu)
      item
    end
  end
  
  def show_login_window
    @login_window = LoginWindow.alloc.initWithContentRect([[0, 0], [320, 150]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @login_window.delegate = self
    @login_window.orderFrontRegardless
    @login_window.makeMainWindow
  end
  
  def start_timer_item
    @start_timer_item ||= begin
      item = NSMenuItem.alloc.initWithTitle("Start Timer", action:nil, keyEquivalent:"")
      item.setSubmenu(self.start_timer_menu)
      item
    end
  end
  
  def start_timer_menu
    @start_timer_menu ||= begin
      menu = StartTimerMenu.new
      menu.delegate = self.delegate
      menu.build_menu
      menu
    end
  end
  
  def timer_menu
    @timer_menu ||= begin
      menu = TimerMenu.new
      menu.delegate = self.delegate
      menu
    end
  end
  
end