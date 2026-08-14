//
//  SearchViewModel.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import Observation

protocol SearchViewModelType: Observable {
    var searchText: String { get set }
    var searchItems: [GithubSearchItem] { get set }
    
    func search(text: String)
    
}

final class SearchViewModel: SearchViewModelType {
    var searchText: String
    var searchItems: [GithubSearchItem] = []
    
    init(searchText: String = "", initialSearchItems: [GithubSearchItem] = []) {
        self.searchText = searchText
        self.searchItems = initialSearchItems
    }
    
    func search(text: String) {
        
    }
}
