class AppDelegate

  def applicationDidFinishLaunching(notification)
    status_item.setMenu(main_menu)
    update_status_item
    true
  end

  def main_menu
    @main_menu ||= begin
      menu = MainMenu.new
      menu
    end
  end

  def status_item
    @status_item ||= begin
      status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSSquareStatusItemLength).init
      status_item.setHighlightMode(true)
      status_item
    end
  end

  def update_status_item
    if Tick::Timer.current && Tick::Timer.current.running?
      status_item.setImage(NSImage.imageNamed("stopwatch-filled.pdf"))
      status_item.setAlternateImage(NSImage.imageNamed("stopwatch-filled-alt.pdf"))
    else
      status_item.setImage(NSImage.imageNamed("stopwatch.pdf"))
      status_item.setAlternateImage(NSImage.imageNamed("stopwatch-alt.pdf"))
    end
  end

end
