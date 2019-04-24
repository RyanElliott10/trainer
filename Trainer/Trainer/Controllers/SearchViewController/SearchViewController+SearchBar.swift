//
//  SearchViewController+SearchBar.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/23/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchResultsUpdating {
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.isActive = true
        definesPresentationContext = true

        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
    
}
