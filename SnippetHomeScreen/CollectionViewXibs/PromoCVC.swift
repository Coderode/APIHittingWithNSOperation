//
//  Type1CVC.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import UIKit
import SkeletonView
struct Promo {
    var promoImageURL : String?
    init(imageUrl: String){
        self.promoImageURL = imageUrl
    }
}

class PromoCVC: UICollectionViewCell {

    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var dataSource : Promo?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.isSkeletonable = true
        self.showSkeleton()
    }
    
    func showSkeleton(){
        let gradient = SkeletonGradient(baseColor: UIColor.lightGray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        self.imageView.isSkeletonable = true
        self.imageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
    }
    
    func hideSkeleton(){
        self.imageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(2))
    }
    
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.setData(content: .none)
        }
    }
    func updateAppearance(content : Promo?, animated : Bool = true){
        DispatchQueue.main.async {
          if animated {
            UIView.animate(withDuration: 0.5) {
              self.setData(content: content)
            }
          } else {
            self.setData(content: content)
          }
        }
    }
    func setData(content : Promo?){
        self.dataSource = content
        if let data = content {
            self.hideSkeleton()
            cellContentView.backgroundColor = .white
            self.imageView.imageFromUrl(urlString: data.promoImageURL!, handler: nil)
        }
    }
}
