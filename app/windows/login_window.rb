class LoginWindow < NSWindow
  attr_accessor :delegate

  def bring_to_front
    self.orderFrontRegardless
    self.makeMainWindow
    NSApp.activateIgnoringOtherApps(true)
  end

  def build_window
    # YAY MotionKit!!
    @layout = LoginLayout.new
    self.contentView = @layout.view

    @layout.login_button.target = self
    @layout.login_button.action = "log_in"
  end

  def initWithContentRect(rect, styleMask:styleMask, backing:backing, defer:defer)
    super
    set_title_and_frame
    build_window
    bring_to_front
    self
  end

  def log_in
    company = @layout.company_field.stringValue
    email = @layout.email_field.stringValue
    password = @layout.password_field.stringValue
    Tick.log_in(company, email, password) do |session|
      if session
        self.delegate.build_menu
        self.close
      else
        # TODO: Present message to user
        ap "Could not log in"
      end
    end
  end

  def set_title_and_frame
    self.title = "Log in to Tick"
    self.setFrame([[(self.screen.frame.size.width / 2) - 150, (self.screen.frame.size.height / 2)], [300, 180]], display:true)
  end

end
