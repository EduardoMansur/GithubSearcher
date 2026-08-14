//
//  RepositoryDetailViewModel.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import Foundation
import Observation

protocol RepositoryDetailViewModelType: Observable {
    var title: String { get }
    var avatarURL: URL? { get }
    var description: String { get }
    var stars: String { get set }
    var forked: String { get set }
    var lastUpdated: String { get set }
    var linkURL: URL? { get }
}

@MainActor
@Observable
final class RepositoryDetailViewModel: RepositoryDetailViewModelType {
    
    let title: String
    let avatarURL: URL?
    let description: String
    var stars: String
    var forked: String
    var lastUpdated: String
    var linkURL: URL?
    
    @ObservationIgnored private let repository: GithubSearchItem
    
    init(repo: GithubSearchItem) {
        self.repository = repo
        
        title = repository.name
        description = repository.description ?? "none"
        avatarURL = URL(string: repository.owner.avatarURL)
        stars = "\(repository.stars)"
        forked = "(\(repository.forks))"
        if let lastUpdated = repository.lastUpdated {
            self.lastUpdated = (try? Date(lastUpdated, strategy: .iso8601).formatted(.relative(presentation: .named))) ?? "never"
        } else {
            lastUpdated = "never"
        }
        
        linkURL = URL(string: repository.htmlURL) 
    }
}
