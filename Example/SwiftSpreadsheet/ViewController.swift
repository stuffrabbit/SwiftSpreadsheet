//
//  ViewController.swift
//  SwiftSpreadsheet
//
//  Created by Wojtek Kordylewski on 03/23/2017.
//  Copyright (c) 2017 Wojtek Kordylewski. All rights reserved.
//

import UIKit
import SwiftSpreadsheet

class DefaultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var infoLabel: UILabel!
}

class SpreadsheetCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var infoLabel: UILabel!
}

class ViewController: UIViewController {
    
    let defaultCellIdentifier = "DefaultCellIdentifier"
    let defaultSupplementaryViewIdentifier = "DefaultSupplementaryViewIdentifier"
    
    struct DecorationViewNames {
        static let topLeft = "SpreadsheetTopLeftDecorationView"
        static let topRight = "SpreadsheetTopRightDecorationView"
        static let bottomLeft = "SpreadsheetBottomLeftDecorationView"
        static let bottomRight = "SpreadsheetBottomRightDecorationView"
    }
    
    struct SupplementaryViewNames {
        static let left = "SpreadsheetLeftRowView"
        static let right = "SpreadsheetRightRowView"
        static let top = "SpreadsheetTopColumnView"
        static let bottom = "SpreadsheetBottomColumnView"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataArray: [[Double]]
    let numberFormatter = NumberFormatter()
    let personCount = 30
    let lightGreyColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    
    required init?(coder aDecoder: NSCoder) {
        
        //Setting up demo data
        var finalArray = [[Double]]()
        for _ in 0 ..< self.personCount {
            var subArray = [Double]()
            for _ in 0 ..< 12 {
                subArray.append(Double(arc4random() % 4000))
            }
            finalArray.append(subArray)
        }
        self.dataArray = finalArray
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DecorationView Nibs
        let topLeftDecorationViewNib = UINib(nibName: DecorationViewNames.topLeft, bundle: nil)
        let topRightDecorationViewNib = UINib(nibName: DecorationViewNames.topRight, bundle: nil)
        let bottomLeftDecorationViewNib = UINib(nibName: DecorationViewNames.bottomLeft, bundle: nil)
        let bottomRightDecorationViewNib = UINib(nibName: DecorationViewNames.bottomRight, bundle: nil)
        
        //SupplementaryView Nibs
        let topSupplementaryViewNib = UINib(nibName: SupplementaryViewNames.top, bundle: nil)
        let bottomSupplementaryViewNib = UINib(nibName: SupplementaryViewNames.bottom, bundle: nil)
        let leftSupplementaryViewNib = UINib(nibName: SupplementaryViewNames.left, bundle: nil)
        let rightSupplementaryViewNib = UINib(nibName: SupplementaryViewNames.right, bundle: nil)
        
        //Setup Layout
        let layout = SpreadsheetLayout(delegate: self,
                                       topLeftDecorationViewType: .asNib(topLeftDecorationViewNib),
                                       topRightDecorationViewType: .asNib(topRightDecorationViewNib),
                                       bottomLeftDecorationViewType: .asNib(bottomLeftDecorationViewNib),
                                       bottomRightDecorationViewType: .asNib(bottomRightDecorationViewNib))
        
        //Default is true, set false here if you do not want some of these sides to remain sticky
        layout.stickyLeftRowHeader = true
        layout.stickyRightRowHeader = true
        layout.stickyTopColumnHeader = true
        layout.stickyBottomColumnFooter = true
        
        self.collectionView.collectionViewLayout = layout
        
        
        //Register Supplementary-View nibs for the given ViewKindTypes
        self.collectionView.register(leftSupplementaryViewNib, forSupplementaryViewOfKind: SpreadsheetLayout.ViewKindType.leftRowHeadline.rawValue, withReuseIdentifier: self.defaultSupplementaryViewIdentifier)
        self.collectionView.register(rightSupplementaryViewNib, forSupplementaryViewOfKind: SpreadsheetLayout.ViewKindType.rightRowHeadline.rawValue, withReuseIdentifier: self.defaultSupplementaryViewIdentifier)
        self.collectionView.register(topSupplementaryViewNib, forSupplementaryViewOfKind: SpreadsheetLayout.ViewKindType.topColumnHeader.rawValue, withReuseIdentifier: self.defaultSupplementaryViewIdentifier)
        self.collectionView.register(bottomSupplementaryViewNib, forSupplementaryViewOfKind: SpreadsheetLayout.ViewKindType.bottomColumnFooter.rawValue, withReuseIdentifier: self.defaultSupplementaryViewIdentifier)
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.defaultCellIdentifier, for: indexPath) as? DefaultCollectionViewCell else { fatalError("Invalid cell dequeued") }
        
        let value = self.dataArray[indexPath.section][indexPath.item]
        cell.infoLabel.text = self.numberFormatter.string(from: NSNumber(value: value))
        
        cell.backgroundColor = indexPath.item % 2 == 1 ? self.lightGreyColor : UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewKind = SpreadsheetLayout.ViewKindType(rawValue: kind) else { fatalError("View Kind not available for string: \(kind)") }
        
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: viewKind.rawValue, withReuseIdentifier: self.defaultSupplementaryViewIdentifier, for: indexPath) as! SpreadsheetCollectionReusableView
        switch viewKind {
        case .leftRowHeadline:
            supplementaryView.infoLabel.text = "Section \(indexPath.section)"
        case .rightRowHeadline:
            let value = self.dataArray[indexPath.section].reduce(0) { $0 + $1 }
            supplementaryView.infoLabel.text = self.numberFormatter.string(from: NSNumber(value: value))
        case .topColumnHeader:
            supplementaryView.infoLabel.text = "Item \(indexPath.item)"
            supplementaryView.backgroundColor = indexPath.item % 2 == 1 ? self.lightGreyColor : UIColor.white
        case .bottomColumnFooter:
            let value = self.dataArray.map { $0[indexPath.item] }.reduce(0) { $0 + $1 }
            supplementaryView.infoLabel.text = self.numberFormatter.string(from: NSNumber(value: value))
            supplementaryView.backgroundColor = indexPath.item % 2 == 1 ? self.lightGreyColor : UIColor.white
        default:
            break
        }
        
        return supplementaryView
    }
    
}

//MARK: - Spreadsheet Layout Delegate

extension ViewController: SpreadsheetLayoutDelegate {
    func spreadsheet(layout: SpreadsheetLayout, heightForRowsInSection section: Int) -> CGFloat {
        return 50
    }
    
    func widthsOfSideRowsInSpreadsheet(layout: SpreadsheetLayout) -> (left: CGFloat?, right: CGFloat?) {
        return (120, 120)
    }
    
    func spreadsheet(layout: SpreadsheetLayout, widthForColumnAtIndex index: Int) -> CGFloat {
        return 80
    }
    
    func heightsOfHeaderAndFooterColumnsInSpreadsheet(layout: SpreadsheetLayout) -> (headerHeight: CGFloat?, footerHeight: CGFloat?) {
        return (70, 70)
    }
}
