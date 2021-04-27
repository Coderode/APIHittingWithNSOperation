//
//  Type2Cell.swift
//  SnippetHomeScreen
//
//  Created by Sandeep on 22/04/21.
//

import UIKit

struct SummaryCollectionTableViewCell {
    var collectionTitle : String?
    var bookSummaries : [BookSummary]?
    init(collectionTitle : String, bookSummaries: [BookSummary]){
        self.collectionTitle = collectionTitle
        self.bookSummaries = bookSummaries
    }
}

class SummaryCollectionTVC: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    var dataSource : SummaryCollectionTableViewCell?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SummaryCVC", bundle: .main), forCellWithReuseIdentifier: "SummaryCVC")
    }
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.setData(content: .none)
        }
    }
    
    func updateAppearance(content : SummaryCollectionTableViewCell?, animated : Bool = true){
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
    
    func setData(content :SummaryCollectionTableViewCell? ){
        self.dataSource = content
        if let data = content {
            moreButton.setTitle("More", for: .normal)
            moreButton.setTitleColor(.black, for: .normal)
            moreButton.backgroundColor = .systemGray2
            typeLabel.backgroundColor = .white
            typeLabel.text = data.collectionTitle
            self.collectionView.reloadData()
        }else{
            moreButton.setTitle("", for: .normal)
            moreButton.setTitleColor(.systemGray2, for: .normal)
            moreButton.backgroundColor = .systemGray2
            typeLabel.backgroundColor = .systemGray2
            typeLabel.text = ""
        }
    }
}

extension SummaryCollectionTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.bookSummaries?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "SummaryCVC", for: indexPath) as? SummaryCVC  else {
            return UICollectionViewCell()
        }
        if let data = self.dataSource {
            cell.updateAppearance(content: data.bookSummaries?[indexPath.row])
        }else{
            cell.updateAppearance(content: .none)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 + 20, height: collectionView.frame.size.height)
    }
    
    
}
