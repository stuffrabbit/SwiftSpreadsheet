# SwiftSpreadsheet

[![Version](https://img.shields.io/cocoapods/v/SwiftSpreadsheet.svg?style=flat)](http://cocoapods.org/pods/SwiftSpreadsheet)
[![License](https://img.shields.io/cocoapods/l/SwiftSpreadsheet.svg?style=flat)](http://cocoapods.org/pods/SwiftSpreadsheet)
[![Platform](https://img.shields.io/cocoapods/p/SwiftSpreadsheet.svg?style=flat)](http://cocoapods.org/pods/SwiftSpreadsheet)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Updated for Swift 4.0

## Installation

SwiftSpreadsheet is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftSpreadsheet"
```
## Demo

![Output sample](https://thumbs.gfycat.com/SilentLightheartedAmmonite-size_restricted.gif)


## Quick start

A short introduction on how to get started:

The rows of the spreadsheet represent a section in the collection view, with columns being the respective items.
The leftmost and the rightmost elements of the spreadsheet (`LeftRowHeadline` and `RightRowHeadline`), as well as the topmost and the bottommost elements (`TopColumnHeader` and `BottomColumnFooter`) are represented as `UISupplementaryView`, which — if needed — have to be registered with the respective identifiers of the provided enum `ViewKindType` (refer to the example code). 
 
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

Implement the provided `SpreadsheetLayoutDelegate`. The methods are straightforward. Simply pass `nil` wherever you do not want supplementary views to be displayed (leftmost, rightmost, topmost and bottommost).


Reload Layout:
```swift
//On Layout:
layout.resetLayoutCache()
//Helper Method for collection view
collectionView.reloadDataAndSpreadsheetLayout()
```

So in short:
1) Register the respective objects of type `UISupplementaryView` you want to use with the provided identifiers of the enum `ViewKindType`.
2) Create a `UINib` object for each `UIDecrationView` (corner of the Spreadsheet) and pass it upon initialization of the layout.
3) Initialize the layout with the provided convenience initializer and pass the delegate as well as the required decoration views.
4) Implement the `SpreadsheetLayoutDelegate`.
5) Set the content of your cells and the supplementary views in the data source methods of your collection view.
6) Enjoy ;)

## Questions

Please refer to the demo application or contact me directly.

## Author

Wojtek Kordylewski.
 
indiControl GmbH owns the Copyright of the respective SwiftSpreadsheet.swift file.

## License

SwiftSpreadsheet is available under the MIT license. See the LICENSE file for more info.
