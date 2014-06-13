class SubmitLayout < MotionKit::Layout
  view :content_view

  view :hours_label
  view :hours_field

  view :notes_label
  view :notes_scroll_view
  view :notes_field

  view :cancel_button
  view :submit_button

  def layout
    add NSView, :content_view do
      add NSTextView,  :hours_label
      add NSTextField, :hours_field

      add NSTextView, :notes_label
      add NSScrollView, :notes_scroll_view do
        add NSTextView, :notes_field
      end

      add NSButton, :cancel_button
      add NSButton, :submit_button
    end
  end

  def content_view_style
    constraints do
      bottom.equals(0)
      height.is.at_least(200)
      left.equals(0)
      right.equals(0)
      top.equals(0)
      width.is.at_least(300)
    end
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
      width.equals(55)
    end
  end

  def hours_field_style
    constraints do
      left.equals(:hours_label).plus(60)
      height.equals(23)
      right.equals(-10)
      top.equals(:hours_label).minus(3)
    end

    deferred do
      next_key_view notes_field
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

  def notes_scroll_view_style
    autoresizing_mask       :flexible_height, :flexible_width
    border_type             NSBezelBorder
    focus_ring_type         NSFocusRingTypeExterior
    has_vertical_scroller   true
    has_horizontal_scroller false

    constraints do
      bottom.equals(-52)
      height.is.at_least(56)
      left.equals(:hours_field)
      right.equals(:hours_field)
      top.equals(:notes_label).minus(3)
    end

    deferred do
      document_view notes_field
    end
  end

  def notes_field_style
    autoresizing_mask    :flexible_height, :flexible_width
    editable             true
    text_container_inset [0, 5]

    deferred do
      next_key_view hours_field
    end
  end

  def cancel_button_style
    bezel_style NSRoundedBezelStyle
    title       "Cancel"

    constraints do
      bottom.equals(-12)
      left.equals(:notes_field)
      height.equals(30)
      width.equals(90)
    end
  end

  def submit_button_style
    bezel_style NSRoundedBezelStyle
    title       "Submit"

    constraints do
      bottom.equals(-12)
      height.equals(:cancel_button)
      right.equals(:notes_field)
      width.equals(:cancel_button)
    end
  end

end
