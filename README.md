<img src="https://avatars0.githubusercontent.com/u/67895642?s=400&u=4e7fe101556e810c541efa77b891de9e5b5d4642&v=4"  width="200" height="200" class="inline"/>

# SLEssentials

[![CI Status](https://img.shields.io/travis/vukasin-popovic/SLEssentials.svg?style=flat)](https://travis-ci.org/vukasin-popovic/SLEssentials)
[![Version](https://img.shields.io/cocoapods/v/SLEssentials.svg?style=flat)](https://cocoapods.org/pods/SLEssentials)
[![License](https://camo.githubusercontent.com/daefd168f1ad0b5702c984b445147c5a332f3a55/68747470733a2f2f696d672e736869656c64732e696f2f636f636f61706f64732f6c2f41757468656e7469636174696f6e4d616e616765722e7376673f7374796c653d666c6174)](https://github.com/swifty-labs/SLEssentials/blob/1.0.8/LICENSE)
[![Platform](https://camo.githubusercontent.com/e578d111c7729fc5111f771f6a66e1035c01e562/68747470733a2f2f696d672e736869656c64732e696f2f636f636f61706f64732f702f41757468656e7469636174696f6e4d616e616765722e7376673f7374796c653d666c6174)](https://cocoapods.org/pods/SLEssentials)

**SLEssentials** is set of Swift utilities. It contains most of Swift staff that have found a purpose in almost all iOS applications.

## Modules

- [NibHelper](#NibHelper)
- [KeyboardContentManager](#KeyboardContentManager)
- [UIViewControllerEmbeding](#UIViewControllerEmbeding)
- [AuthenticationManager](#AuthenticationManager)

## Requirements

- iOS 10.0+
- XCode 11+
- Swift 5.0+

## Installation

To integrate **SLEssentials** into your Xcode project, specify it in your Podfile:

```ruby
platform :ios, '10.0'
pod 'SLEssentials', :git => 'https://github.com/swifty-labs/SLEssentials.git'
```

### Subspecs

There are multi subspecs available, like *NibHelper, KeyboardContentManager, UIViewControllerEmbeding* and others. It means, you can install one or more of the **SLEssentials** modules. By default, you get all modules, so, if you need specific module you must specify it.

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

## Authors

vukasin-popovic, vukasin.popovic@swiftylabs.io

slobodan-ristic, slobodan.ristic@swiftylabs.io

## License

SLEssentials is available under the MIT license. See the [LICENSE](https://github.com/swifty-labs/SLEssentials/blob/1.0.8/LICENSE) file for more info.
