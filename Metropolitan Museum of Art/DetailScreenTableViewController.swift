//
//  DetailScreenTableViewController.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import UIKit
import SDWebImage

class DetailScreenTableViewController: UITableViewController {
    
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var primaryImageView: UIImageView!
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
    
    var primaryImageURL = ""
    var additionalImageURLs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        initUI()
        fetchDetailsData()
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
    func fetchDetailsData() {
        
        
        let urlString = FURL.getObjectURL(for: id)
        
        activityIndicator.isHidden = false
        NetworkManager.shared.get(urlString: urlString, responseType: ObjectResponseModel.self) { [self]
            model in
            
            primaryImageURL = model.primaryImageSmall ?? ""
            additionalImageURLs = model.additionalImages ?? []
            
            
            DispatchQueue.main.async { [self] in
                activityIndicator.isHidden = true
                departmentLabel.text = model.department
                objectNameLabel.text = model.objectName
                objectTitleLabel.text = model.title
                titleLabel.text = model.title
                
                primaryImageView.sd_setImage(with: URL(string: primaryImageURL), completed: nil)
                
                if additionalImageURLs.isEmpty {
                    galleryContainerViewHeightConstraint.constant = 0
                } else {
                    galleryCollectionView.reloadData()
                }
                
            }
        }
        
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        if isFavorite {
            // already favorite
            showAlert(title: "Already added to favorites!", message: "")
        } else {
            
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            PersistenceManager().addToDefaults(value: id)
            // show alert, added to favorite
            showAlert(title: "Done!", message: "Added to favorites")
        }
    }
}


extension DetailScreenTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        additionalImageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        
        cell.galleryImageView.sd_setImage(with: URL(string: additionalImageURLs[indexPath.row]), completed: nil)
        
        return cell
    }
    
    
    
}
