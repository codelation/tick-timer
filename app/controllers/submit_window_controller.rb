class SubmitWindowController < NSWindowController
  attr_accessor :timer

  def init
    super
    self.window = SubmitWindow.alloc.initWithContentRect([[0, 0], [300, 180]],
                    styleMask: NSClosableWindowMask|NSResizableWindowMask|NSTitledWindowMask,
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
      notes: self.window.notes_field.string
    }) do
      self.main_menu.successful_submission
      self.close
    end
  end

  def timer=(timer)
    super
    self.window.title = "#{timer.task.project.name} - #{timer.task.name}"
    self.window.hours_field.stringValue = timer.time_elapsed_in_hours.round(2).to_s
  end

end
