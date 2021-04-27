//
//  Type1Cell.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import UIKit

struct PromoTableViewCell {
    var promos : [Promo]?
    init(promos : [Promo]){
        self.promos = promos
    }
}

class PromoTVC: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource : PromoTableViewCell?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PromoCVC", bundle: .main), forCellWithReuseIdentifier: "PromoCVC")
    }
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.setData(content: .none)
        }
    }
    
    func updateAppearance(content : PromoTableViewCell?, animated : Bool = true){
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
    func setData(content : PromoTableViewCell?){
        self.dataSource = content
        if let _ = content {
            self.collectionView.reloadData()
        }
    }
}

extension PromoTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.promos?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCVC", for: indexPath) as? PromoCVC else {
            return UICollectionViewCell()
        }
        if let data  = self.dataSource {
            cell.updateAppearance(content: data.promos?.first)
        }else{
            cell.updateAppearance(content: .none)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: collectionView.frame.size.height)
    }
}
