//
//  Type2CVC.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import UIKit

struct BookSummary {
    var coverImageUrl : String
    var title : String?
    var rating : Float?
    init(imageUrl : String, title: String, rating : Float){
        self.coverImageUrl = imageUrl
        self.title = title
        self.rating = rating
    }
}
class SummaryCVC: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingImage1: UIImageView!
    @IBOutlet weak var ratingImage2: UIImageView!
    @IBOutlet weak var ratingImage3: UIImageView!
    @IBOutlet weak var ratingImage4: UIImageView!
    @IBOutlet weak var ratingImage5: UIImageView!
    var dataSource : BookSummary?
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.image = UIImage()
        coverImageView.backgroundColor = .lightGray
        titleLabel.text = ""
        titleLabel.backgroundColor = .lightGray
        ratingView.backgroundColor = .lightGray
        ratingImage1.backgroundColor = .lightGray
        
        ratingImage2.backgroundColor = .lightGray
        ratingImage3.backgroundColor = .lightGray
        ratingImage4.backgroundColor = .lightGray
        ratingImage5.backgroundColor = .lightGray
        
        ratingImage1.tintColor = .lightGray
        ratingImage2.tintColor = .lightGray
        ratingImage3.tintColor = .lightGray
        ratingImage4.tintColor = .lightGray
        ratingImage5.tintColor = .lightGray
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
            coverImageView.imageFromUrl(urlString: data.coverImageUrl, handler: nil)
            coverImageView.backgroundColor = .white
            titleLabel.text = data.title
            titleLabel.textColor = .black
            titleLabel.backgroundColor = .white
            ratingView.backgroundColor = .white
            ratingImage1.backgroundColor = .white
            
            ratingImage2.backgroundColor = .white
            ratingImage3.backgroundColor = .white
            ratingImage4.backgroundColor = .white
            ratingImage5.backgroundColor = .white
            
            ratingImage1.tintColor = .lightGray
            ratingImage2.tintColor = .lightGray
            ratingImage3.tintColor = .lightGray
            ratingImage4.tintColor = .lightGray
            ratingImage5.tintColor = .lightGray
            
        }else{
            coverImageView.image = UIImage()
            coverImageView.backgroundColor = .lightGray
            titleLabel.text = ""
            titleLabel.textColor = .lightGray
            titleLabel.backgroundColor = .lightGray
            ratingView.backgroundColor = .lightGray
            ratingImage1.backgroundColor = .lightGray
            
            ratingImage2.backgroundColor = .lightGray
            ratingImage3.backgroundColor = .lightGray
            ratingImage4.backgroundColor = .lightGray
            ratingImage5.backgroundColor = .lightGray
            
            ratingImage1.tintColor = .lightGray
            ratingImage2.tintColor = .lightGray
            ratingImage3.tintColor = .lightGray
            ratingImage4.tintColor = .lightGray
            ratingImage5.tintColor = .lightGray
        }
    }

}
