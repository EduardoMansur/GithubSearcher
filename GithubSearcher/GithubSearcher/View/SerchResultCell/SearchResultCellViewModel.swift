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
}

protocol SearchResultCellViewModelType: Observable  {
    var repositoryName: String { get }
    var description: String { get }
    var numberOfStars: String { get }
    var ownerAvatar: URL? { get }
}
