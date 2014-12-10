class NSApplication
  alias_method :original_send_event, :sendEvent

  def sendEvent(event)
    if event.type == NSKeyDown
      input_key = event.charactersIgnoringModifiers.lowercaseString

      if (event.modifierFlags & NSDeviceIndependentModifierFlagsMask) == NSCommandKeyMask
        case input_key
        when "a"
          return if self.sendAction("selectAll:", to: nil, from: self)
        when "c"
          return if self.sendAction("copy:", to: nil, from: self)
        when "v"
          return if self.sendAction("paste:", to: nil, from: self)
        when "x"
          return if self.sendAction("cut:", to: nil, from: self)
        when "z"
          return if self.sendAction("undo:", to: nil, from: self)
        end
      end

      if (event.modifierFlags & NSDeviceIndependentModifierFlagsMask) == (NSCommandKeyMask | NSShiftKeyMask) ||
         (event.modifierFlags & NSDeviceIndependentModifierFlagsMask) == (NSCommandKeyMask | NSShiftKeyMask | NSAlphaShiftKeyMask)
        if input_key == "z"
          return if self.sendAction("redo:", to: nil, from: self)
        end
      end
    end
    self.original_send_event(event)
  end
end
