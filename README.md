# SwiftSpreadsheet

[![CI Status](http://img.shields.io/travis/stuffrabbit/SwiftSpreadsheet.svg?style=flat)](https://travis-ci.org/stuffrabbit/SwiftSpreadsheet)
[![Version](https://img.shields.io/cocoapods/v/SwiftSpreadsheet.svg?style=flat)](http://cocoapods.org/pods/SwiftSpreadsheet)
[![License](https://img.shields.io/cocoapods/l/SwiftSpreadsheet.svg?style=flat)](http://cocoapods.org/pods/SwiftSpreadsheet)
[![Platform](https://img.shields.io/cocoapods/p/SwiftSpreadsheet.svg?style=flat)](http://cocoapods.org/pods/SwiftSpreadsheet)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Swift 3.0 or newer.
## Installation

SwiftSpreadsheet is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftSpreadsheet"
```

## Quick start

A short introduction on how to get started:

The rows of the spreadsheet represent a section in the collection view, with columns being the respective items.
The the leftmost and the rightmost elements of the spreadsheet (`LeftRowHeadline`and `RightRowHeadline`), as well as the topmost and the bottommost elements (`TopColumnHeader`and `BottomColumnFooter`) are represented as `SupplementaryView`, which — if needed — have to be registered with the respective identifier of the provided enum `ViewKindType` (refer to the example code). 
 
The corners of the resulting spreadsheet are represented as `UIDecorationView` which can be passed as `UINib` upon initialization of the Layout.

A short example:

```swift
//Register SupplementaryViews first, then initialize the layout with optional Nibs for the DecorationViews
let layout = SpreadsheetLayout(delegate: self,
                               topLeftDecorationViewNib: topLeftDecorationViewNib,
                               topRightDecorationViewNib: topRightDecorationViewNib,
                               bottomLeftDecorationViewNib: bottomLeftDecorationViewNib,
                               bottomRightDecorationViewNib: bottomRightDecorationViewNib)

//Default is true, set false here if you do not want some of these sides to remain sticky
layout.stickyLeftRowHeader = true
layout.stickyRightRowHeader = true
layout.stickyTopColumnHeader = true
layout.stickyBottomColumnFooter = true

self.collectionView.collectionViewLayout = layout

```

Reload Layout:
```swift
//On Layout:
layout.resetLayoutCache()
//Helper Method for collection view
collectionView.reloadDataAndSpreadsheetLayout()
```
## Questions

Please refer to the demo application or contact me directly.

## Author

Wojtek Kordylewski, 
indiControl GmbH

## License

SwiftSpreadsheet is available under the MIT license. See the LICENSE file for more info.
