class LoginWindow < NSWindow
  attr_reader :company_field, :email_field, :password_field

  def bring_to_front
    self.orderFrontRegardless
    NSApp.activateIgnoringOtherApps(true)
  end

  def build_window
    # YAY MotionKit!!
    @layout = LoginLayout.new
    self.contentView = @layout.view

    # Set focus to the company field
    self.initialFirstResponder = @layout.company_field

    @layout.cancel_button.target = self
    @layout.cancel_button.action = :close

    @layout.login_button.target = self.windowController
    @layout.login_button.action = :log_in
  end

  def company_field
    @layout.company_field
  end

  def email_field
    @layout.email_field
  end

  def initWithContentRect(rect, styleMask: styleMask, backing: backing, defer: defer)
    super
    set_title_and_frame
    build_window
    bring_to_front
    self
  end

  def password_field
    @layout.password_field
  end

  def set_title_and_frame
    self.title = "Log in to Tick"
    self.setFrame([[(self.screen.frame.size.width / 2) - 150, (self.screen.frame.size.height / 2)], [300, 180]], display:true)
  end

end
