class AppDelegate

  def applicationDidFinishLaunching(notification)
    status_item.setMenu(main_menu)
    update_status_item
    true
  end

  def main_menu
    @main_menu ||= MainMenu.new
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
      status_image = NSImage.imageNamed("stopwatch-filled.pdf")
    else
      status_image = NSImage.imageNamed("stopwatch.pdf")
    end
    status_image.setTemplate(true)
    status_item.setImage(status_image)
  end

end
