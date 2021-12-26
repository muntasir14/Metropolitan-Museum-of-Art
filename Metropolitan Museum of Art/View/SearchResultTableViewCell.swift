//
//  SearchResultTableViewCell.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import UIKit

// to get the button press action from search screen
protocol SearchCellFavoriteDelegate {
    
    func favoriteButtonTapped(row: Int)
}


class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // change favorite button appearance with state
    var isFavorite: Bool {
        
        set {
            newValue ? favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal) : favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
        get {
            if favoriteButton.backgroundImage(for: .normal) == UIImage(systemName: "heart.fill") {
                return true
            }
            return false
        }
    }
    
    var favoriteButtonDelegate: SearchCellFavoriteDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
        if isFavorite {
            
            // remove from favorite
            
            isFavorite = false
        } else {
            
            // add in favorite list
            
            isFavorite = true
        }
        
        favoriteButtonDelegate.favoriteButtonTapped(row: contentView.tag)
    }
    

}
