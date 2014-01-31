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
  app.name = "Tick Timer"
  app.icon = "icon.icns"
  app.identifier = "com.81designs.ticktimer"
  app.info_plist["LSUIElement"] = true
  app.info_plist["NSHumanReadableCopyright"] = "Copyright © 2014 81designs. All rights reserved."
  app.files += Dir.glob("./lib/*/*.rb")
  
  app.pods do
    pod "GDataXML-HTML", "~> 1.1.0"
    pod "SSKeychain", "~> 1.2.1"
  end
end
