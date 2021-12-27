//
//  SearchScreenViewController.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var searchForResultsLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var favoriteList: [String] = []
    var searchResultList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initUI()
    }
    
    // UI Initialization
    func initUI() {
        
        // searchBar delegate
        searchBar.delegate = self
        
        // tableview delegates
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        
        // collectionview delegates
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.delegate = self
        
        favoriteList = PersistenceManager().getDefaults()
        favoriteCollectionView.reloadData()
        print("favorite list:", favoriteList)
        
        emptyLabel.isHidden = !favoriteList.isEmpty
        searchForResultsLabel.isHidden = !searchResultList.isEmpty
    }
    
}



extension SearchScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
        cell.contentView.tag = indexPath.row
        cell.favoriteButtonDelegate = self
        cell.idLabel.text = String(searchResultList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "DetailScreenTableViewController") as! DetailScreenTableViewController
        vc.id = String(searchResultList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.titleLabel.text = favoriteList[indexPath.row]
        
        return cell
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let key = searchBar.text!
        activityIndicator.isHidden = false
        print("search tapped: \(key)")
        view.endEditing(true)
        handleSearch(key: key)
    }
    
    func handleSearch(key: String) {
        
        let searchURLString = FURL.getSearchURL(for: key)
        NetworkManager.shared.get(urlString: searchURLString, responseType: SearchResponseModel.self) { [self]
            model in
            print("model in searchVC:", model)
            searchResultList = model.objectIDs
            DispatchQueue.main.async {
                activityIndicator.isHidden = true
                searchResultTableView.isHidden = false
                searchForResultsLabel.isHidden = true
                searchResultTableView.reloadData()
            }
        }
    }
}


extension SearchScreenViewController: SearchCellFavoriteDelegate {
    
    func favoriteButtonTapped(row: Int) {
        
        print("favorite tapped for row: \(row)")
        emptyLabel.isHidden = true
        favoriteList.append(String(searchResultList[row]))
        PersistenceManager().addToDefaults(value: String(searchResultList[row]))
        favoriteCollectionView.reloadData()
    }
}
