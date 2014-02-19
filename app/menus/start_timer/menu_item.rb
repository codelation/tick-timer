module StartTimer
  
  class MenuItem < NSMenuItem
    attr_reader :start_timer_menu

    def initWithTitle(title, action:action, keyEquivalent:keyEquivalent)
      super
      start_timer_menu.build_menu
      self.setSubmenu(start_timer_menu)
      self
    end

    def start_timer_menu
      @start_timer_menu ||= Menu.new
    end

  end
  
end