import Foundation
import UIKit

class CollectionView: UICollectionView {
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if intrinsicContentSize != bounds.size {
            invalidateIntrinsicContentSize()
        }
    }
}
