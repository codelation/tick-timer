module Timer

  class MenuItem < NSMenuItem
    attr_accessor :timer
  
    def initWithTimer(timer)
      self.timer = timer
      self.initWithTitle(get_title, action:nil, keyEquivalent:"")
      self
    end
  
  private
  
    def get_title
      if self.timer
        title  = self.timer.task.project.name
        title += " - #{self.timer.task.name}"
        title += " - #{self.timer.displayed_time}"
        title += " - Paused" if self.timer.is_paused
        title
      end
    end
  
  end
  
end