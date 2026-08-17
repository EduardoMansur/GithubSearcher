//
//  SearchResultRepository.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import NetworkLayer
import Foundation

final class SearchResultRepository: RepositorySearching {
    let networkClient: NetworkClient

    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }

    func searchRepositories(language: String) async throws -> GithubSearchResponse {
        let request = GithubSearchRequest(language: language)

        let result: GithubSearchResponse = try await networkClient.execute(request)
        
        return result
    }
}

protocol RepositorySearching {
    func searchRepositories(language: String) async throws -> GithubSearchResponse
}
