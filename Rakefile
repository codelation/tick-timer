# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require "motion/project/template/osx"

begin
  require "bundler"
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = "Timer for Tick"
  app.icon = "icon.icns"
  app.identifier = "com.codelation.ticktimer"
  app.info_plist["LSUIElement"] = true
  app.info_plist["NSHumanReadableCopyright"] = "Copyright © 2014 Codelation. All rights reserved."
end
