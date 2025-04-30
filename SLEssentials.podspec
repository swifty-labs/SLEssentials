#
# Be sure to run `pod lib lint SLEssentials.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
	s.name             = 'SLEssentials'
	s.version          = '1.1.0'
	s.summary          = 'SLEssentials is a set of Swift utilities for iOS and tvOS.'

	s.description      = <<-DESC
	SLEssentials is a collection of Swift utilities, extensions, and lightweight managers
	used in most iOS applications. It includes tools for networking, keyboard handling,
	app state observation, loading indicators, and more.
	DESC

	s.homepage         = 'https://github.com/swifty-labs/SLEssentials'
	s.license          = { :type => 'MIT', :file => 'LICENSE' }
	s.authors          = {
		'vukasin-popovic' => 'vukasin.popovic@swiftylabs.io',
		'slobodan-ristic' => 'slobodan.ristic@swiftylabs.io'
	}

	s.source           = { :git => 'https://github.com/swifty-labs/SLEssentials.git', :tag => s.version.to_s, :submodules => true }

	s.ios.deployment_target = '11.0'
	s.tvos.deployment_target = '15.0'
	s.swift_version = '5.7'

	s.default_subspec = ['Core', 'AuthenticationManager', 'Networking']

	# Shared code used across multiple subspecs
	s.subspec 'Shared' do |sh|
		sh.source_files = 'Sources/SLEssentials/Utilities/**/*.swift',
		'Sources/iOS/Utilities/**/*.swift'
	end

	s.subspec 'Core' do |co|
		co.source_files = [
		'Sources/SLEssentials/Logger/*.swift',
		'Sources/SLEssentials/Managers/TableViewDataSource/*.swift',
		'Sources/SLEssentials/Managers/AppStateObserver/*.swift',
		'Sources/SLEssentials/Managers/LoadingIndicator/*.swift',
		'Sources/SLEssentials/Managers/ImageLoader/*.swift',
		'Sources/SLEssentials/Managers/TextTapManager/*.swift',
		'Sources/SLEssentials/Managers/Debouncer/*.swift',
		'Sources/SLEssentials/Managers/LinkedList/*.swift',
		'Sources/SLEssentials/Managers/Throttler/*.swift',
		'Sources/iOS/Managers/KeyboardManager/*.swift',
		'Sources/iOS/Managers/ImagePicker/*.swift'
		]
		co.dependency 'SLEssentials/Shared'
		co.dependency 'TinyConstraints'
	end

	s.subspec 'AuthenticationManager' do |am|
		am.source_files = 'Sources/iOS/Managers/AuthenticationManager/*.swift'
	end

	s.subspec 'Networking' do |net|
		net.source_files = 'Sources/SLEssentials/Networking/*.swift'
		net.dependency 'Alamofire'
		net.dependency 'SLEssentials/Shared'
	end

	s.subspec 'tvOS' do |tv|
		tv.platform = :tvos, '15.0'
		tv.source_files = [
		'Sources/SLEssentials/Logger/*.swift',
		'Sources/SLEssentials/Utilities/**/*.swift',
		'Sources/SLEssentials/Managers/TextTapManager/*.swift'
		]
	end
end
