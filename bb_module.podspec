Pod::Spec.new do |s|
  s.name             = 'bb_module'
  s.version          = '0.1.0'
  s.summary          = 'BBModule is a module and routing system to help write good modularized ios apps'
  s.description      = <<-DESC
BBModule does two things

Modules:
Provides a set of base classes for modules that allow you to write good modularized code.
Modules respond to routes and present requested view controllers

Routing:
Provides a simple routing system to allow inter module communication.
                       DESC

  s.homepage         = 'https://github.com/BrianBal/bb_module'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Brian Bal' => 'briantbal@gmail.com' }
  s.source           = { :git => 'https://github.com/Brian Bal/bb_module.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'bb_module/Classes/**/*'
  s.frameworks = 'UIKit'
end
