//
//  SearchResultCellViewModel.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import Foundation
import Observation

final class SearchResultCellViewModel: SearchResultCellViewModelType {
    let repositoryName: String
    let description: String
    let numberOfStars: String
    let ownerAvatar: URL?
    
    init(repositoryName: String, description: String, numberOfStars: String, ownerAvatar: URL?) {
        self.repositoryName = repositoryName
        self.description = description
        self.numberOfStars = numberOfStars
        self.ownerAvatar = ownerAvatar
    }
    
    init(githubItem: GithubSearchItem) {
        self.repositoryName = githubItem.name
        self.description = githubItem.description ?? ""
        self.numberOfStars = "\(githubItem.stars)"
        self.ownerAvatar = URL(string: githubItem.owner.avatarURL)
    }
}

protocol SearchResultCellViewModelType: Observable  {
    var repositoryName: String { get }
    var description: String { get }
    var numberOfStars: String { get }
    var ownerAvatar: URL? { get }
}
