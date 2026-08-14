//
//  GithubSearchRequest.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import NetworkLayer

struct GithubSearchRequest: NetworkRequest {
    typealias Response = GithubSearchResponse

    let language: String

    var baseURL: String { "https://api.github.com" }
    var path: String { "/search/repositories" }
    var method: HTTPMethod { .get }
    var headers: [String: String]? {
        ["Accept": "application/vnd.github+json",
         "X-GitHub-Api-Version": "2026-03-10"]
    }
    var queryParameters: [String: String]? {
        ["q": "\(language)"]
    }
}
