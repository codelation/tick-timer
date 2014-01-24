class TimerMenu < NSMenu
  
  def build_menu
    self.removeAllItems
    
    if TimersController.instance.running
      pause_item = NSMenuItem.alloc.initWithTitle("Pause", action:"pause_timer", keyEquivalent:"")
      pause_item.target = self.delegate
      self.addItem(pause_item)
    else
      start_item = NSMenuItem.alloc.initWithTitle("Start", action:"start_timer", keyEquivalent:"")
      start_item.target = self.delegate
      self.addItem(start_item)
    end
    
    submit_item = NSMenuItem.alloc.initWithTitle("Submit", action:"submit_entry", keyEquivalent:"")
    submit_item.target = self.delegate
    self.addItem(submit_item)
  end
  
end