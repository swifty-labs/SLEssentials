<img src="https://avatars0.githubusercontent.com/u/67895642?s=400&u=4e7fe101556e810c541efa77b891de9e5b5d4642&v=4"  width="200" height="200" class="inline"/>

# SLEssentials

[![CI Status](https://img.shields.io/travis/vukasin-popovic/SLEssentials.svg?style=flat)](https://travis-ci.org/vukasin-popovic/SLEssentials)
[![Version](https://img.shields.io/cocoapods/v/SLEssentials.svg?style=flat)](https://cocoapods.org/pods/SLEssentials)
[![License](https://camo.githubusercontent.com/daefd168f1ad0b5702c984b445147c5a332f3a55/68747470733a2f2f696d672e736869656c64732e696f2f636f636f61706f64732f6c2f41757468656e7469636174696f6e4d616e616765722e7376673f7374796c653d666c6174)](https://github.com/swifty-labs/SLEssentials/blob/1.0.8/LICENSE)
[![Platform](https://camo.githubusercontent.com/e578d111c7729fc5111f771f6a66e1035c01e562/68747470733a2f2f696d672e736869656c64732e696f2f636f636f61706f64732f702f41757468656e7469636174696f6e4d616e616765722e7376673f7374796c653d666c6174)](https://cocoapods.org/pods/SLEssentials)

SLEssentials is set of Swift utilities. It contains most of Swift staff that have found a purpose in almost all iOS applications.

## Modules

- NibHelper
- KeyboardContentManager
- UIViewControllerEmbeding

## Requirements

- iOS 10.0+
- XCode 11+
- Swift 5.0+

## Installation

To integrate SLEssentials into your Xcode project, specify it in your Podfile:

```ruby
platform :ios, '10.0'
pod 'SLEssentials', :git => 'https://github.com/swifty-labs/SLEssentials.git'
```

### Subspecs

There are multi subspecs available, like NibHelper, KeyboardContentManager, UIViewControllerEmbeding and others. It means, you can install one or more of the SLEssentials modules. By default, you get all modules, so, if you need specific module you must specify it.

Podfile example:

```ruby
platform :ios, '10.0'
pod 'SLEssentials/NibHelper', :git => 'https://github.com/swifty-labs/SLEssentials.gi
```
## Author

vukasin-popovic, vukasin.popovic@swiftylabs.io

## License

SLEssentials is available under the MIT license. See the [LICENSE](https://github.com/swifty-labs/SLEssentials/blob/1.0.8/LICENSE) file for more info.
