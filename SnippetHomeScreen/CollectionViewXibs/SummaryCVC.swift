//
//  Type2CVC.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import UIKit
import Cosmos
import SkeletonView
struct BookSummary {
    var coverImageUrl : String
    var title : String?
    var rating : Double?
    init(imageUrl : String, title: String, rating : Double){
        self.coverImageUrl = imageUrl
        self.title = title
        self.rating = rating
    }
}
class SummaryCVC: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    var dataSource : BookSummary?
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.image = UIImage()
        coverImageView.backgroundColor = .lightGray
        titleLabel.text = ""
        titleLabel.backgroundColor = .lightGray
        
        let gradient = SkeletonGradient(baseColor: UIColor.lightGray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        self.coverImageView.isSkeletonable = true
        self.titleLabel.isSkeletonable = true
        self.ratingView.isSkeletonable = true
        self.coverImageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        self.titleLabel.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        self.ratingView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        ratingView.settings.updateOnTouch = false
        ratingView.settings.fillMode = .precise
        ratingView.settings.starSize = 18

        ratingView.settings.starMargin = 1
        ratingView.settings.filledColor = UIColor.orange
        ratingView.settings.emptyBorderColor = UIColor.lightGray
        ratingView.settings.filledBorderColor = UIColor.orange

    }
    
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.setData(content: .none)
        }
    }
    func updateAppearance(content : BookSummary?, animated : Bool = true){
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
    func setData(content : BookSummary?){
        self.dataSource = content
        if let data = content {
            self.coverImageView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(3))
            self.titleLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(3))
            self.ratingView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(3))
            coverImageView.imageFromUrl(urlString: "http://snippet-alb-testing-422974023.us-east-2.elb.amazonaws.com" + data.coverImageUrl, handler: nil)
            coverImageView.backgroundColor = .white
            titleLabel.text = data.title
            titleLabel.textColor = .black
            titleLabel.backgroundColor = .white
            ratingView.rating = data.rating!
            
        }
    }

}
