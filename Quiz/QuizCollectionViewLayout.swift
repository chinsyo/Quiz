//
//  QuizCollectionViewLayout.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import UIKit

class QuizCollectionViewLayout: UICollectionViewLayout {
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()

    override func prepare() {
        
        guard let collectionView = self.collectionView else { return }
        
        let hPadding: CGFloat = 30
        let tPadding: CGFloat = 100
        let bPadding: CGFloat = 80
        
        let width = collectionView.bounds.size.width - hPadding * 2
        let height = collectionView.bounds.size.height - tPadding - bPadding
        
        for i in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(row: i, section: 0)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: CGFloat(i) * collectionView.bounds.size.width + hPadding,
                                     y: tPadding,
                                     width: width,
                                     height: height)
            
            self.layoutAttributes.append(attribute)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            guard let collectionView = self.collectionView else { return CGSize.zero }
            let width = CGFloat(collectionView.numberOfItems(inSection: 0)) * collectionView.bounds.size.width
            return CGSize(width: width, height: collectionView.bounds.size.height)
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return self.collectionView?.bounds.size == newBounds.size
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let collectionView = self.collectionView else {
            return super.layoutAttributesForElements(in: rect)
        }

        for attribute in layoutAttributes {
            
            let distance: CGFloat = collectionView.bounds.size.width
            let itemOffset: CGFloat = attribute.center.x - collectionView.contentOffset.x

            let position = itemOffset / distance - 0.5
            
            let scaleFactor = 1.0 - 0.15 * abs(position)
            
            attribute.alpha = 1.0 - abs(position)
            attribute.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            
        }
        return layoutAttributes
    }

}
