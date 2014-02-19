class AppDelegate
  attr_reader :main_menu, :projects, :status_item

  def applicationDidFinishLaunching(notification)
    status_item.setMenu(main_menu)
    Tick.login("81designs", "brian@81designs.com", "fKR4Ukwa6cAmXyuivXVj") do
      build_main_menu
    end
  end
  
  def build_main_menu
    ap "HELLO"
    main_menu.build_menu
  end
  
  def main_menu
    @main_menu ||= MainMenu.new
  end
  
  def status_item
    @status_item ||= begin
      status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSSquareStatusItemLength).init
      status_item.setHighlightMode(true)
    
      status_image = NSImage.imageNamed("stopwatch.pdf")
      status_item.setImage(status_image)
    
      alt_status_image = NSImage.imageNamed("stopwatch-alt.pdf")
      status_item.setAlternateImage(alt_status_image)
      
      status_item
    end
  end

end