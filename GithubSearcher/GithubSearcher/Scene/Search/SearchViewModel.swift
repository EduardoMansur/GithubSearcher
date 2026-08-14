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
    
    func search(text: String) async throws 
    
}


@Observable
@MainActor
final class SearchViewModel: SearchViewModelType {
    var searchText: String
    var searchItems: [GithubSearchItem] = []
    
    @ObservationIgnored
    private let repository: RepositorySearching
    
    init(searchText: String = "", initialSearchItems: [GithubSearchItem] = [], repository: RepositorySearching) {
        self.searchText = searchText
        self.searchItems = initialSearchItems
        self.repository = repository
    }
    
    func search(text: String) async throws {
        guard !text.isEmpty else { return }
        searchItems = try await repository.searchRepositories(language: text).items
    }
}
