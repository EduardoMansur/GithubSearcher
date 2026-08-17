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
    var state: SearchViewState { get }
    
    func search(text: String) async
}

@Observable
@MainActor
final class SearchViewModel: SearchViewModelType {
    var searchText: String
    var searchItems: [GithubSearchItem] = []
    
    var state: SearchViewState
    
    @ObservationIgnored
    private let repository: RepositorySearching
    private var lastCompletedSearch: String?
    
    init(searchText: String = "", initialSearchItems: [GithubSearchItem] = [], repository: RepositorySearching) {
        self.searchText = searchText
        self.searchItems = initialSearchItems
        self.repository = repository
        self.state = .initial
    }
    
    func search(text: String) async {
        guard lastCompletedSearch != text else {
            return
        }
        
        searchItems = []
        
        guard !text.isEmpty else {
            state = .initial
            return
        }
  
        state = .loading
        
        do {
            searchItems = try await repository.searchRepositories(language: text).items
            state = searchItems.isEmpty ? .noResults : .loaded
            lastCompletedSearch = text
        } catch {
            state = .error(error)
        }
    }
}

enum SearchViewState {
    case initial
    case loading
    case loaded
    case error(Error)
    case noResults
}
