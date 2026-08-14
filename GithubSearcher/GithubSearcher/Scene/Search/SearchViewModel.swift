//
//  SearchViewModel.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import Observation

protocol SearchViewModelType: Observable {
    var searchText: String { get set }
}

final class SearchViewModel: SearchViewModelType {
    var searchText: String
    
    init(searchText: String = "") {
        self.searchText = searchText
    }
    
}
