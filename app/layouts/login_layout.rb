class LoginLayout < MotionKit::Layout
  view :company_label
  view :company_field

  view :email_label
  view :email_field

  view :password_label
  view :password_field

  view :cancel_button
  view :login_button

  def layout
    add NSTextView,  :company_label
    add NSTextField, :company_field

    add NSTextView,  :email_label
    add NSTextField, :email_field

    add NSTextView,        :password_label
    add NSSecureTextField, :password_field

    add NSButton, :cancel_button
    add NSButton, :login_button
  end

  def company_label_style
    alignment        NSRightTextAlignment
    draws_background false
    editable         false
    string           "Company:"

    constraints do
      left.equals(10)
      height.equals(20)
      top.equals(20)
      width.equals(75)
    end
  end

  def company_field_style
    constraints do
      left.equals(:company_label).plus(80)
      height.equals(23)
      right.equals(-10)
      top.equals(:company_label).minus(3)
    end

    deferred do
      next_key_view email_field
    end
  end

  def email_label_style
    alignment        NSRightTextAlignment
    draws_background false
    editable         false
    string           "Email:"

    constraints do
      left.equals(:company_label)
      height.equals(:company_label)
      top.equals(:company_label).plus(32)
      width.equals(:company_label)
    end
  end

  def email_field_style
    constraints do
      left.equals(:company_field)
      height.equals(:company_field)
      right.equals(:company_field)
      top.equals(:email_label).minus(3)
    end

    deferred do
      next_key_view password_field
    end
  end

  def password_label_style
    alignment        NSRightTextAlignment
    draws_background false
    editable         false
    string           "Password:"

    constraints do
      left.equals(:email_label)
      height.equals(:email_label)
      top.equals(:email_label).plus(32)
      width.equals(:email_label)
    end
  end

  def password_field_style
    constraints do
      left.equals(:email_field)
      height.equals(:email_field)
      right.equals(:email_field)
      top.equals(:password_label).minus(3)
    end

    deferred do
      next_key_view company_field
    end
  end

  def cancel_button_style
    bezel_style NSRoundedBezelStyle
    title       "Cancel"

    constraints do
      left.equals(:password_field)
      height.equals(30)
      top.equals(:password_field).plus(32)
      width.equals(90)
    end
  end

  def login_button_style
    bezel_style NSRoundedBezelStyle
    title       "Log In"

    constraints do
      height.equals(:cancel_button)
      right.equals(:password_field)
      top.equals(:password_field).plus(32)
      width.equals(:cancel_button)
    end
  end

end
