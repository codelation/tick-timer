module SessionActions

  def log_out
    Tick.log_out
    build_menu
  end

  def log_in
    @login_window ||= LoginWindowController.new
    @login_window.showWindow(self)
    NSApp.activateIgnoringOtherApps(true)
  end

  def successful_login
    build_menu
  end

end
