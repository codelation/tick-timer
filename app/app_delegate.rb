# NSApplication.sharedApplication.delegate
class AppDelegate
  attr_accessor :timers_controller, :main_menu, :status_item

  def applicationDidFinishLaunching(notification)
    @timers_controller = TimersController.instance
    
    @status_item = NSStatusBar.systemStatusBar.statusItemWithLength(NSSquareStatusItemLength).init
    @status_item.setHighlightMode(true)
    
    status_image = NSImage.imageNamed("stopwatch.pdf")
    @status_item.setImage(status_image)
    
    alt_status_image = NSImage.imageNamed("stopwatch-alt.pdf")
    @status_item.setAlternateImage(alt_status_image)
    
    @main_menu = MainMenu.new
    @main_menu.delegate = @timers_controller
    @main_menu.build_menu
    @status_item.setMenu(@main_menu)
  end

end