class LoginWindowController < NSWindowController

  def init
    super
    self.window = LoginWindow.alloc.initWithContentRect([[0, 0], [300, 180]],
                    styleMask: NSTitledWindowMask|NSClosableWindowMask,
                    backing: NSBackingStoreBuffered,
                    defer: false)
    self
  end

  def log_in
    company = self.window.company_field.stringValue
    email = self.window.email_field.stringValue
    password = self.window.password_field.stringValue
    Tick.log_in(company, email, password) do |session|
      if session
        main_menu.successful_login
        self.close
      else
        error = NSError.alloc.initWithDomain("Tick Authentication", code: 401, userInfo: {})
        alert = NSAlert.alertWithError(error)
        alert.runModal
      end
    end
  end

  def main_menu
    NSApplication.sharedApplication.delegate.main_menu
  end

end
