module ActionRows

  def action_rows
    @action_rows ||= [{
      title: "About Timer for Tick",
      target: self,
      action: "show_about_window:"
    }, {
      title: "Quit",
      action: "terminate:"
    }]
  end

  def action_sections
    @action_sections ||= [{
      rows: [{
        title: "About Timer for Tick",
        target: self,
        action: "show_about_window:"
      }, {
        title: "Visit #{Tick::Session.current.company}.tickspot.com",
        target: self,
        action: "visit_tickspot"
      }]
    }, {
      rows: [{
        title: "Log Out",
        target: self,
        action: "log_out"
      }, {
        title: "Quit",
        action: "terminate:"
      }]
    }]
  end

  def show_about_window(sender)
    NSApp.orderFrontStandardAboutPanel(sender)
    NSApp.activateIgnoringOtherApps(true)
  end

  def visit_tickspot
    NSWorkspace.sharedWorkspace.openURL(NSURL.URLWithString("https://#{Tick::Session.current.company}.tickspot.com"))
  end

end
