# StatefulCollections
> Simple stateful collection views for iOS in Swift.


[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

StatefulCollections is a small and lightweight Swift framework that allows to create UITableviews and UICollectionViews that support empty, loading and error states as easy as possible.

It can be partially customized to allow greater flexibility while keeping things simple. It has a nice balance between customizing its views and ease of use.

![](header.png)

## Features

- [x] Simple to use
- [x] Customizable
- [x] Supports empty, loading and error states

## Requirements

- iOS 13.0+
- Xcode 11.3

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `StatefulCollections` by adding it to your `Podfile`:

```ruby
platform :ios, '13.0'
use_frameworks!
pod 'StatefulCollections'
```

To get the full benefits import `StatefulCollections` wherever you import UIKit

``` swift
import UIKit
import StatefulCollections
```

## Usage example

```swift
import EZSwiftExtensions
ez.detectScreenShot { () -> () in
    print("User took a screen shot")
}
```

## Contribute

We would love you for the contribution to **StatefulCollections**, check the ``LICENSE`` file for more info.

## Meta

Guillem Espejo –  g.espejogarcia@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/yourname/github-link](https://github.com/dbader/)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
