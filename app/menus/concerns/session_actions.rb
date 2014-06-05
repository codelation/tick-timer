module SessionActions

  def log_out
    Tick.log_out
    build_menu
  end

  def log_in
    @login_window = LoginWindow.alloc.initWithContentRect([[0, 0], [300, 180]],
                      styleMask: NSTitledWindowMask|NSClosableWindowMask,
                      backing: NSBackingStoreBuffered,
                      defer: false)
    @login_window.delegate = self
  end

end
