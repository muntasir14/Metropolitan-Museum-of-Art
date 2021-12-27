//
//  DetailScreenTableViewController.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import UIKit

class DetailScreenTableViewController: UITableViewController {
    
   
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var galleryContainerView: UIView!
    @IBOutlet weak var galleryContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    @IBOutlet weak var objectNameLabel: UILabel!
    @IBOutlet weak var objectTitleLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var id: String!
    var isFavorite: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    func initUI() {
        
        if PersistenceManager().isInDefaultsList(value: id) {
            
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            isFavorite = true
        } else {
            
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            isFavorite = false
        }
        
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        if isFavorite {
            // already favorite
        } else {
            
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            // show alert, added to favorite
        }
    }
}


extension DetailScreenTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        
        cell.galleryImageView.image = UIImage(systemName: "heart.fill")
        
        return cell
    }
    
    
    
}
