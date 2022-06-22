<img src="https://avatars0.githubusercontent.com/u/67895642?s=400&u=4e7fe101556e810c541efa77b891de9e5b5d4642&v=4"  width="200" height="200" class="inline"/>

# SLEssentials

[![CI Status](https://img.shields.io/travis/vukasin-popovic/SLEssentials.svg?style=flat)](https://travis-ci.org/vukasin-popovic/SLEssentials)
[![License](https://camo.githubusercontent.com/daefd168f1ad0b5702c984b445147c5a332f3a55/68747470733a2f2f696d672e736869656c64732e696f2f636f636f61706f64732f6c2f41757468656e7469636174696f6e4d616e616765722e7376673f7374796c653d666c6174)](https://github.com/swifty-labs/SLEssentials/blob/1.0.8/LICENSE)
[![Platforms](https://img.shields.io/badge/Platforms-iOS_tvOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS_tvOS-Green?style=flat-square)
[![Version](https://img.shields.io/cocoapods/v/SLEssentials.svg?style=flat)](https://cocoapods.org/pods/SLEssentials)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

**SLEssentials** is set of Swift utilities. It contains most of Swift staff that have found a purpose in almost all iOS and tvOS applications.

## Modules

- [NibHelper](#NibHelper)
- [KeyboardContentManager](#KeyboardContentManager)
- [UIViewControllerEmbeding](#UIViewControllerEmbeding)
- [AuthenticationManager](#AuthenticationManager)
- [tvOS](#tvOS)

## Requirements

- iOS 10.0+
- tvOS 15.0+
- XCode 11+
- Swift 5.0+

## Installation

To integrate **SLEssentials** into your Xcode project, specify it in your Podfile:

```ruby
platform :ios, '10.0'
pod 'SLEssentials', :git => 'https://github.com/swifty-labs/SLEssentials.git'
```

### Subspecs

There are multi subspecs available, like *NibHelper, KeyboardContentManager, UIViewControllerEmbeding, tvOS* and others. It means, you can install one or more of the **SLEssentials** modules. By default, you get all modules, so, if you need specific module you must specify it.

Podfile example:

```ruby
platform :ios, '10.0'
pod 'SLEssentials/NibHelper', :git => 'https://github.com/swifty-labs/SLEssentials.git'
```

<div id="NibHelper"></div>

## NibHelper

*NibHelper* is based on UIView, UIViewController, UICollectionViewCell and UITableViewCell extensions. It is used for quick and easy views and cells instantiation. UICollectionViewCell and UITableViewCell extensions have a similar implementation.

```swift
import SLEssentials

tableView.registerNib(TableCell.self)
let cell: TableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
```

To create initial UIViewController instance using UIStoryboard:

```swift
import SLEssentials

let controller = UINavigationController.initial() // it is implies that storyboard is Main 

let controller =  UINavigationController.initial(fromStoryboardNamed: "Login") // for specified storyboard
```

To create UIViewController instance using UIStoryboard:

```swift
import SLEssentials

let controller = SignUpController.instantiate(fromStoryboardNamed: "Login")
```

To create UIVew instance, first, your custom UIView have to implement ViewLoadable protocol:

```swift
import SLEssentials

final class ImageOverlay: UIView, ViewLoadable {
  ...
}
```

and now you can instatiate it:

```swift
let overlay = ImageOverlay.instance 
```

<div id="KeyboardContentManager"></div>

## KeyboardContentManager

*KeyboardContentManager* modul contains actually two managers, *ConstraintKeyboardContentManager* and *ScrollViewKeyboardContentManager*, both implementing KeyboardManageable protocol. It purpose is to handle keyboard, in UIScrollView, when we use *ScrollViewKeyboardContentManager*, manipulating with content inset, and in UIView, when we use *ConstraintKeyboardContentManager*, maniputaing with view's bottom constraint.

All we need to do is to register and unregister keyborad notifications:

```swift
import SLEssentials

override func viewWillAppear(_ animated: Bool) {
	super.viewWillAppear(animated)
		
	keyboardManager.registerForKeyboardNotifications()
}
	
override func viewWillDisappear(_ animated: Bool) {
	super.viewWillDisappear(animated)
		
	keyboardManager.unregisterForKeyboardNotifications()
} 
```

Additional implementation is to use some of two manager's handlers:

```swift
keyboardManager.keyboardHides{ 
   ...
}

keyboardManager.keyboardShows {
   ...
}
```

<div id="UIViewControllerEmbeding"></div>

## UIViewControllerEmbeding

*UIViewControllerEmbeding* is modul based on simple UIViewController extension and it's used for embeding UIViewController into UIView using constraints, or specifying controller's frame. User can unembed UIViewController also.

```swift
import SLEssentials

@IBOutlet weak var viewContainer: UIView!
 
 ...
 
let controller = UIViewController() 

embed(viewController: controller, in: viewContainer)

embed(viewController: controller, withFrame: viewContainer.frame, in: viewContainer)

controller.unembed()
```

## AuthenticationManager

*AuthenticationManager* is a manager with which you can easily and simply determine whether the device supports biometrics (and if supported, which type of biometrics is available).


Create instance of manager with protocol type 'AuthenticationManageable'
```swift
import SLEssentials
 
let authenticationManager: AuthenticationManageable = AuthenticationManager()
```


With this instance you can use 2 functions:

- check whether device support touch or face ID. Function return error if authentication isn't available.
```swift
switch authenticationManager.biometricsType(with: .biometricsAndPasscode) {
case .success(let biometricType):
	print(biometricType)
case .failure(let error):
	print(error)
}
```

- present authentication to user

reason - display the reason for authentication with touch ID

Note: - For authentication with face ID must be included the NSFaceIDUsageDescription key in your app's Info.plist file.
```swift
<key>NSFaceIDUsageDescription</key>
<string>Confirm your Face ID</string>
```

cancelTitle - set a custom message for the Cancel button that appears in various alert views

fallBackTitle - title will be shown when first authentication attempt is failed

If cancelTitle and fallBackTitle set to nil, system provides default title.

```swift
let reason = "Confirm your fingerprint"
let cancelTitle = "Cancel"
let presentOptions = MTAuthenticationPresentOptions(authenticationType: .biometricsAndPasscode, reason: reason, cancelTitle: cancelTitle, fallBackTitle: nil)

authenticationManager.presentAuthenticationToUser(with: presentOptions) { result in
	switch result {
	case .success(let biometricType):
		print(biometricType)
	case .failure(let error):
		print(error)
	}
}
```
<div id="tvOS"></div>

## tvOS

tvOS is a module where all modules are included except KeyboardContentManager and AuthenticationManager

Podfile:

```ruby
platform :tvos, '15.0'
pod 'SLEssentials/tvOS', :git => 'https://github.com/swifty-labs/SLEssentials.git'
```

## Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

SLEssentials support SwiftPM from version 5.6.0. To use SwiftPM, you should use Xcode 11+ to open your project. Click File -> Add Packages, enter [SLEssentials](https://github.com/swifty-labs/SLEssentials) repo's URL.

Once you have your Swift package set up, adding SLEssentials as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/swifty-labs/SLEssentials")
]
```
If you want to use the basic functions, you need to import SLEssentials.

```swift
import SLEssentials
```

If you want to use functions for iOS, you need to import iOS.

```swift
import iOS
```

If you want to use function for tvOS, you need to import only SLEssentials.

```swift
import SLEssentials
```

## Authors

vukasin-popovic, vukasin.popovic@swiftylabs.io

slobodan-ristic, slobodan.ristic@swiftylabs.io

milos-stankovic, milos.stankovic@swiftylabs.io

## License

SLEssentials is available under the MIT license. See the [LICENSE](https://github.com/swifty-labs/SLEssentials/blob/1.0.8/LICENSE) file for more info.
