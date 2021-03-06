class SubmitWindow < NSWindow
  attr_reader :hours_field, :notes_field

  def build_window
    # YAY MotionKit!!
    @layout = SubmitLayout.new
    self.contentView = @layout.view

    # Set focus to the notes field
    self.initialFirstResponder = @layout.notes_field
    @layout.notes_field.delegate = self

    @layout.cancel_button.target = self
    @layout.cancel_button.action = :close

    @layout.submit_button.target = self.windowController
    @layout.submit_button.action = :submit_timer
  end

  def hours_field
    @layout.hours_field
  end

  def initWithContentRect(rect, styleMask: styleMask, backing: backing, defer: defer)
    super
    build_window
    set_frame
    self
  end

  def notes_field
    @layout.notes_field
  end

  def reset
    @layout.notes_field.string = ""
    self.makeFirstResponder(@layout.notes_field)
  end

  def set_frame
    self.setFrame([[(self.screen.frame.size.width / 2) - 150, (self.screen.frame.size.height / 2)], [300, 180]], display:true)
  end

  def textView(text_view, doCommandBySelector: command_selector)
    if command_selector == :"insertTab:"
      self.makeFirstResponder(@layout.hours_field)
      true
    else
      false
    end
  end

end
