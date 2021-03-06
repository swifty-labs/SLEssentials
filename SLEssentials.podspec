#
# Be sure to run `pod lib lint SLEssentials.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SLEssentials'
  s.version          = '1.0.13'
  s.summary          = 'SLEssentials is set of Swift utilities'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  SLEssentials contains most of Swift staff that have found application in almost all ios applications. It is based on extensions, managers and wrappers that covers most of application functionality.
                       DESC

  s.homepage         = 'https://github.com/swifty-labs/SLEssentials'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'vukasin-popovic' => 'vukasin.popovic@swiftylabs.io', 'slobodan-ristic' => 'slobodan.ristic@swiftylabs.io' }
  s.source           = { :git => 'https://github.com/swifty-labs/SLEssentials.git', :tag => s.version.to_s, :submodules => true }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.default_subspec = ['NibHelper', 'KeyboardContentManager', 'AuthenticationManager', 'TextTapManager', 'Extensions']
  
  # s.resource_bundles = {
  #   'SLEssentials' => ['SLEssentials/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.subspec 'NibHelper' do |nh|
    nh.source_files = 'SLEssentials/Classes/NibHelper/*.swift'
  end
  
  s.subspec 'KeyboardContentManager' do |kcm|
    kcm.source_files = 'SLEssentials/Classes/KeyboardContentManager/*.swift'
  end
  
	s.subspec 'Extensions' do |ex|
		ex.source_files = 'SLEssentials/Classes/Extensions/*.swift'
	end
	
	s.subspec 'AuthenticationManager' do |am|
    am.source_files = 'SLEssentials/Classes/AuthenticationManager/*.swift'
  end
	
	s.subspec 'TextTapManager' do |ttm|
    ttm.source_files = 'SLEssentials/Classes/TextTapManager/*.swift'
  end
  
end
