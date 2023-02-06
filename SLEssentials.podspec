#
# Be sure to run `pod lib lint SLEssentials.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
	s.name             = 'SLEssentials'
	s.version          = '1.0.16'
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

	s.default_subspec = ['Utilities', 'KeyboardManager', 'AuthenticationManager', 'TextTapManager', 'AppStateObserver', 'Debouncer', 'ImageLoader', 'ImagePicker', 'LinkedList', 'LoadingIndicator', 'TableViewDataSource', 'Throttler', 'Logger', 'Networking']

	# s.resource_bundles = {
	#   'SLEssentials' => ['SLEssentials/Assets/*.png']
	# }

	# s.public_header_files = 'Pod/Classes/**/*.h'
	# s.frameworks = 'UIKit', 'MapKit'

	s.subspec 'Utilities' do |uti|
		uti.source_files = 'Sources/SLEssentials/Utilities/**/*.swift'
		uti.dependency 'TinyConstraints'
	end

	s.subspec 'KeyboardManager' do |km|
		km.source_files = 'Sources/iOS/KeyboardManager/*.swift'
	end

	s.subspec 'AuthenticationManager' do |am|
		am.source_files = 'Sources/iOS/AuthenticationManager/*.swift'
	end

	s.subspec 'TextTapManager' do |ttm|
		ttm.source_files = 'Sources/SLEssentials/Managers/TextTapManager/*.swift'
	end

	s.subspec 'AppStateObserver' do |aso|
		aso.source_files = 'Sources/SLEssentials/Managers/AppStateObserver/*.swift'
	end

	s.subspec 'Debouncer' do |deb|
		deb.source_files = 'Sources/SLEssentials/Managers/Debouncer/*.swift'
	end

	s.subspec 'ImageLoader' do |iml|
		iml.source_files = 'Sources/SLEssentials/Managers/ImageLoader/*.swift'
	end

	s.subspec 'ImagePicker' do |imp|
		imp.source_files = 'Sources/SLEssentials/Managers/ImagePicker/*.swift'
	end

	s.subspec 'LinkedList' do |lil|
		lil.source_files = 'Sources/SLEssentials/Managers/LinkedList/*.swift'
	end

	s.subspec 'LoadingIndicator' do |loi|
		loi.source_files = 'Sources/SLEssentials/Managers/LoadingIndicator/*.swift'
	end

	s.subspec 'TableViewDataSource' do |tvd|
		tvd.source_files = 'Sources/SLEssentials/Managers/TableViewDataSource/*.swift'
	end

	s.subspec 'Throttler' do |thr|
		thr.source_files = 'Sources/SLEssentials/Managers/Throttler/*.swift'
	end

	s.subspec 'Logger' do |lo|
		lo.source_files = 'Sources/SLEssentials/Logger/*.swift'
	end

	s.subspec 'Networking' do |net|
		net.source_files = 'Sources/SLEssentials/Networking/*.swift'
		net.dependency 'Alamofire'
		net.dependency 'SLEssentials/Utilities'
	end

	s.subspec 'tvOS' do |tv|
		tv.dependency 'SLEssentials/Logger'
		tv.dependency 'SLEssentials/TextTapManager'
		tv.dependency 'SLEssentials/Utilities'
	end

end
