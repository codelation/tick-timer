class LoginWindow < NSWindow

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
    @layout.login_button.action = "login"
  end

  def initWithContentRect(rect, styleMask:styleMask, backing:backing, defer:defer)
    super
    set_title_and_frame
    build_window
    bring_to_front
    self
  end

  def login
    company = @layout.company_field.stringValue
    email = @layout.email_field.stringValue
    password = @layout.password_field.stringValue
    Tick.log_in(company, email, password) do |session|
      if session
        self.close
      else
        ap "Could not log in"
      end
    end
  end

  def set_title_and_frame
    self.title = "Log in to Tick"
    self.setFrame([[(self.screen.frame.size.width / 2) - 150, (self.screen.frame.size.height / 2)], [300, 180]], display:true)
  end

end
