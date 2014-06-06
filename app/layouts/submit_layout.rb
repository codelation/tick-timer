class SubmitLayout < MotionKit::Layout
  view :hours_label
  view :hours_field

  view :notes_label
  view :notes_field

  view :cancel_button
  view :submit_button

  def layout
    add NSTextView,  :hours_label
    add NSTextField, :hours_field

    add NSTextView,  :notes_label
    add NSTextField, :notes_field

    add NSButton, :cancel_button
    add NSButton, :submit_button
  end

  def hours_label_style
    alignment        NSRightTextAlignment
    draws_background false
    editable         false
    string           "Hours:"

    constraints do
      left.equals(10)
      height.equals(20)
      top.equals(20)
      width.equals(75)
    end
  end

  def hours_field_style
    constraints do
      left.equals(:hours_label).plus(80)
      height.equals(23)
      right.equals(-10)
      top.equals(:hours_label).minus(3)
    end
  end

  def notes_label_style
    alignment        NSRightTextAlignment
    draws_background false
    editable         false
    string           "Notes:"

    constraints do
      left.equals(:hours_label)
      height.equals(:hours_label)
      top.equals(:hours_label).plus(32)
      width.equals(:hours_label)
    end
  end

  def notes_field_style
    constraints do
      left.equals(:hours_field)
      height.equals(56)
      right.equals(:hours_field)
      top.equals(:notes_label).minus(3)
    end
  end

  def cancel_button_style
    bezel_style NSRoundedBezelStyle
    title       "Cancel"

    constraints do
      left.equals(:notes_field)
      height.equals(30)
      top.equals(:notes_field).plus(65)
      width.equals(90)
    end
  end

  def submit_button_style
    bezel_style NSRoundedBezelStyle
    title       "Submit"

    constraints do
      height.equals(:cancel_button)
      right.equals(:notes_field)
      top.equals(:cancel_button)
      width.equals(:cancel_button)
    end
  end

end
