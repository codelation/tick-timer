class SubmitWindowController < NSWindowController
  attr_accessor :timer

  def init
    super
    self.window = SubmitWindow.alloc.initWithContentRect([[0, 0], [300, 180]],
                    styleMask: NSTitledWindowMask|NSClosableWindowMask,
                    backing: NSBackingStoreBuffered,
                    defer: false)
    self
  end

  def main_menu
    NSApplication.sharedApplication.delegate.main_menu
  end

  def submit_timer
    self.timer.submit!({
      hours: self.window.hours_field.floatValue,
      notes: self.window.notes_field.stringValue
    }) do
      self.main_menu.successful_submission
      self.close
    end
  end

  def timer=(timer)
    super
    self.window.title = "#{timer.task.project.name} - #{timer.task.name}"
    self.window.hours_field.floatValue = timer.time_elapsed_in_hours
  end

end
