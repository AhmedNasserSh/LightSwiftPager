Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "LightSwiftPager"
s.summary = "an Easy way to create a pager for ios"
s.requires_arc = true
s.version = "0.1.1"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Ahmed Nasser" => "ahmed.nasser2310@gmail.com" }
s.homepage = "https://github.com/AvaVaas/LightSwiftPager"
s.source = { :git => "https://github.com/AvaVaas/LightSwiftPager.git", :tag => "#{s.version}"}
s.frameworks = 'UIKit'
s.source_files = "LightSwiftPager/*.{swift,.h}"
s.swift_version = '4.0'

end

