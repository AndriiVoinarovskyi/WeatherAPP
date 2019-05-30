//
//  HourlyForecastsCollectionViewLayout.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.29.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import UIKit

class ForecastsCollectionViewLayout: UICollectionViewLayout {
    
    var scrollDirection = UICollectionView.ScrollDirection.horizontal
    
    private var numberOfColumns: Int {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.numberOfItems(inSection: 0)
    }
    private var cellPadding: CGFloat = 0
    private var minSpacingForCells = CGFloat(8)
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.height
    }
    private var contentWidth: CGFloat = 0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let columnWidth = widthForecastsCell + minSpacingForCells
        
        var xOffset = [CGFloat]()
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * (columnWidth))
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let cellHeight = collectionView.bounds.height - 2
            let cellWidth = columnWidth
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: cellWidth, height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentWidth += columnWidth
            column = column + 1
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
