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
  app.short_version = "1.0.1"
  app.version = app.short_version

  app.codesign_certificate = "3rd Party Mac Developer Application: Argyle Media, Inc. (QZ7NP3GN8S)"

  # App Store Sandbox
  app.entitlements["com.apple.security.app-sandbox"] = true
  app.entitlements["com.apple.security.network.client"] = true

  app.info_plist["LSUIElement"] = true
  app.info_plist["NSHumanReadableCopyright"] = "Copyright © 2014 Codelation. All rights reserved."
end
