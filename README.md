<p align="center">
    <img src="docs/Stateful.png">
</p>

> Simple stateful collection views for iOS in Swift.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
![Cocoapods Compatible](https://img.shields.io/cocoapods/v/StatefulCollections?style=plastic)
[![Platform](https://img.shields.io/cocoapods/p/StatefulCollections.svg?style=flat)](http://cocoapods.org/pods/StatefulCollections)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

StatefulCollections is a small and lightweight Swift framework that allows to create UITableviews and UICollectionViews that support empty, loading and error states as easy as possible.

It can be partially customized to allow greater flexibility while keeping things simple. It has a nice balance between view customization and ease of use.

## Features

- [x] Simple to use
- [x] Customizable
- [x] Supports empty, loading and error states

## Requirements

- iOS 13.0+
- Xcode 11.3

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate StatefulCollections into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'StatefulCollections'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding StatefulCollections as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/GuillemEspejo/StatefulCollections.git", .upToNextMajor(from: "1.0.2"))
]
```

## Basic Usage

Import StatefulCollections module wherever you have a reference to a UITableView or UICollectionView that will be used as stateful.
Set your collection style view classes to its matching subclass, StatefulTableView or StatefulCollectionView

```swift
import StatefulCollections
// Other imports ...

class ViewController: UIViewController {

    @IBOutlet weak var tableview: StatefulTableView!
    @IBOutlet weak var collectionview: StatefulCollectionView!

// ...

}
```

Set the class and the import module in storyboard if needed.

<img src="docs/storyboard.png" width="425">

When you want to set the state of the view, set it using `setStateTo`: 
```swift

tableview.setState(to: .loading)
collectionview.setState(to: .empty)

```

Both views support four different states:

| State            | View            |  Image             |  Text             | Use             |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| .normal         | Standard view appearance. | N/A | N/A | Used as default state, when there is content to show. |
| .loading        | Removes cell separator, shows activity indicator and the default text. | N/A | 'Loading...' | Used when loading or processing data (Core Data, networking, file parsing, etc). |
| .emtpy            | Removes cell separator, shows SF Image and the default text. | 'text.badge.xmark' | 'No results' | Used when there are no results to show. |
| .error            | Removes cell separator, shows SF Image and the default text. | 'xmark.octagon' | 'There was an unknown error' | Used when the process of obtaining data for the collection has failed (I/O errors, networking,etc). |

## Customization

StatefulCollections allow a certain degree of customization but tries to keep things as simple as possible.

Although you can't add or remove the basic view components of each state, the ones shown can be customized. Images, labels and separator styles can be freely modified.

For example:
```swift
tableview.setState(to: .error)
```
will give your tableview the following appearance:

<img src="docs/tableviewerror.jpg" width="300">

However, you can set the image and the text to another values:
```swift
let errorImage = UIImage(systemName: "clear")
tableview.setImage(to: errorImage, forState: .error)
tableview.setText(to: "Network error", forState: .error)

// ...

tableview.setState(to: .error)

```

<img src="docs/tableviewerrorcustom.jpg" width="300">


Besides setting custom images and text, you can also set custom tints and colors. The colors are applied to the views itself and are not dependant on the state. 

```swift
tableview.setImageTint(to: .red)
tableview.setTextColor(to: .blue)

```

<img src="docs/tableviewcolorcustom.jpg" width="300">


## Reset states and colors

If you want to reset any state appearance to its original settings, just use `resetState` or `resetAllStates`:  

```swift

tableview.setText(to: "Server error", forState: .error)
tableview.setText(to: "Loading data from disk...", forState: .loading)
tableview.setText(to: "There were no results for your query", forState: .empty)

// ...

tableview.reset(state: .error) // Only error state will be reset

// ...
tableview.resetAllStates() // Every state will be reset to default values

```

Due to the colors being independent of the state, when you need custom colors for a single one, you must set them every time you set that state, and reset them when another one is shown.

```swift
tableview.setImageTint(to: .red)
tableview.setTextColor(to: .yellow)
tableview.setState(to: .error)

// ...

tableview.resetTextColor()
tableview.resetImageTint()
tableview.setState(to: .empty)

```

## Contribute

If you want to contribute to **StatefulCollections**, check the ``LICENSE`` file for more info.

## Meta

Guillem Espejo –  g.espejogarcia@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/GuillemEspejo/github-link](https://github.com/GuillemEspejo/)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
