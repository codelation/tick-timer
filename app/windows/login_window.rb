class LoginWindow < NSWindow
  
  def build_window
    self.title = "Log in to Tick"
    self.setFrame([[(self.screen.frame.size.width / 2) - 160, (self.screen.frame.size.height / 2)], [320, 200]], display:true)
    
    @company_field = NSTextField.alloc.initWithFrame([[10, 120], [300, 20]])
    self.contentView.addSubview(@company_field)
    
    @email_field = NSTextField.alloc.initWithFrame([[10, 90], [300, 20]])
    self.contentView.addSubview(@email_field)
    
    @password_field = NSSecureTextField.alloc.initWithFrame([[10, 60], [300, 20]])
    self.contentView.addSubview(@password_field)
    
    @login_button = NSButton.alloc.initWithFrame([[10, 20], [300, 30]])
    @login_button.action = "login"
    @login_button.bezelStyle = NSRoundedBezelStyle
    @login_button.target = self
    @login_button.title = "Log in"
    self.contentView.addSubview(@login_button)
  end
  
  def initWithContentRect(rect, styleMask:styleMask, backing:backing, defer:defer)
    super
    self.build_window
    self
  end
  
  def login
    company = @company_field.stringValue
    email = @email_field.stringValue
    password = @password_field.stringValue
    self.delegate.login(company, email, password).then(lambda{|result|
      self.close
    }, lambda{|error|
      ap "Error logging in."
      ap error
    })
  end
  
end