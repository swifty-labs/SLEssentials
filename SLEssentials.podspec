#
# Be sure to run `pod lib lint SLEssentials.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
	s.name             = 'SLEssentials'
	s.version          = '1.0.17'
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

	s.ios.deployment_target = '11.0'
	s.tvos.deployment_target = '15.0'
	s.swift_version = '5.7'

	s.default_subspec = ['Core', 'AuthenticationManager', 'Networking']

	# s.resource_bundles = {
	#   'SLEssentials' => ['SLEssentials/Assets/*.png']
	# }

	# s.public_header_files = 'Pod/Classes/**/*.h'
	# s.frameworks = 'UIKit', 'MapKit'

	s.subspec 'Core' do |co|
		co.source_files = 'Sources/SLEssentials/Utilities/**/*.swift', 'Sources/iOS/Managers/KeyboardManager/*.swift', 'Sources/SLEssentials/Logger/*.swift', 'Sources/SLEssentials/Managers/TableViewDataSource/*.swift', 'Sources/SLEssentials/Managers/AppStateObserver/*.swift', 'Sources/SLEssentials/Managers/LoadingIndicator/*.swift', 'Sources/SLEssentials/Managers/ImageLoader/*.swift', 'Sources/iOS/Managers/ImagePicker/*.swift', 'Sources/SLEssentials/Managers/TextTapManager/*.swift', 'Sources/SLEssentials/Managers/Debouncer/*.swift', 'Sources/SLEssentials/Managers/LinkedList/*.swift', 'Sources/SLEssentials/Managers/Throttler/*.swift', 'Sources/iOS/Utilities/**/*.swift'
	end

	s.dependency 'TinyConstraints'

	s.subspec 'AuthenticationManager' do |am|
		am.source_files = 'Sources/iOS/Managers/AuthenticationManager/*.swift'
	end

	s.subspec 'Networking' do |net|
		net.source_files = 'Sources/SLEssentials/Networking/*.swift', 'Sources/SLEssentials/Utilities/**/*.swift', 'Sources/iOS/Utilities/**/*.swift'
		net.dependency 'Alamofire'
	end

	s.subspec 'tvOS' do |tv|
		tv.source_files = 'Sources/SLEssentials/Logger/*.swift', 'Sources/SLEssentials/Utilities/**/*.swift', 'Sources/SLEssentials/Managers/TextTapManager/*.swift'
	end

end
