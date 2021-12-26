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
    
    var favoriteList: [String]? = ["23", "18", "39"]
    
    
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
        
    }
    
    // UserDefaults configuration
    func configureUserDefaults() {
        
        let def = UserDefaults.standard
        def.setValue(favoriteList, forKey: "favoriteList")
        favoriteList = def.stringArray(forKey: "favoriteList")
        favoriteCollectionView.reloadData()
    }
    
}



extension SearchScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        32
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
        cell.contentView.tag = indexPath.row
        cell.favoriteButtonDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = (storyboard?.instantiateViewController(identifier: "DetailTableViewController"))!
        navigationController?.present(vc, animated: true)
    }
}

extension SearchScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        guard let list = favoriteList else {
            return cell
        }
        cell.titleLabel.text = list[indexPath.row]
        
        return cell
    }
}

extension SearchScreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("search tapped: \(searchBar.text!)")
        view.endEditing(true)
    }
}


extension SearchScreenViewController: SearchCellFavoriteDelegate {
    
    func favoriteButtonTapped(row: Int) {
        
        print("favorite tapped for row: \(row)")
    }
}
