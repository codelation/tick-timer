class SubmitWindow < NSWindow
  attr_accessor :delegate, :timer

  def bring_to_front
    self.orderFrontRegardless
    self.makeMainWindow
    NSApp.activateIgnoringOtherApps(true)
  end

  def build_window
    # YAY MotionKit!!
    @layout = SubmitLayout.new
    self.contentView = @layout.view

    @layout.submit_button.target = self
    @layout.submit_button.action = "submit"
  end

  def initWithContentRect(rect, styleMask: styleMask, backing: backing, defer: defer)
    super
    set_title_and_frame
    build_window
    bring_to_front
    self
  end

  def submit
    self.timer.submit!({
      hours: @layout.hours_field.floatValue,
      notes: @layout.notes_field.stringValue
    }) do
      self.delegate.successful_submission
      self.close
    end
  end

  def set_title_and_frame
    self.title = "Log in to Tick"
    self.setFrame([[(self.screen.frame.size.width / 2) - 150, (self.screen.frame.size.height / 2)], [300, 180]], display:true)
  end

  def timer=(timer)
    @layout.hours_field.floatValue = timer.time_elapsed_in_hours
    super
  end

end
