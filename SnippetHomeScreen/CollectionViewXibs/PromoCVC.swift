//
//  Type1CVC.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import UIKit

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
            cellContentView.backgroundColor = .white
            imageView.imageFromUrl(urlString: data.promoImageURL!, handler: nil)
        }else{
            cellContentView.backgroundColor = .lightGray
            imageView.image = UIImage()
        }
    }
}
