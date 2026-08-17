//
//  GithubSearchResponse.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import Foundation


struct GithubSearchResponse: Decodable {
    let items: [GithubSearchItem]
}

struct GithubSearchItem: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String?
    let stars: Int
    let owner: GithubSearchOwner
    let forks: Int
    let lastUpdated: String?
    let htmlURL: String
    
    enum CodingKeys: String, CodingKey {
        case name, description, owner, id
        case stars = "stargazers_count"
        case forks = "forks_count"
        case lastUpdated = "updated_at"
        case htmlURL = "html_url"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresentWithMetrics(String.self, forKey: .name, defaultValue: "no name")
        self.id = try container.decode(Int.self, forKey: .id)
        self.htmlURL = try container.decodeIfPresentWithMetrics(String.self, forKey: .htmlURL, defaultValue: "")
        self.description = try container.decodeIfPresentWithMetrics(String.self, forKey: .description, defaultValue: "no description")
        self.owner = try container.decode(GithubSearchOwner.self, forKey: .owner)
        self.stars = try container.decodeIfPresentWithMetrics(Int.self, forKey: .stars, defaultValue: 0)
        self.forks = try container.decodeIfPresentWithMetrics(Int.self, forKey: .forks, defaultValue: 0)
        self.lastUpdated = try container.decodeIfPresent(String.self, forKey: .lastUpdated)
    }
    
}

extension KeyedDecodingContainer {
    public func decodeIfPresentWithMetrics<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key, defaultValue: T) throws -> T where T : Decodable {
        if let string = try? self.decodeIfPresent(T.self, forKey: key) {
            return string
        } else {
            print("Error decoding \(type)) for key: \(key)")
            return defaultValue
        }
    }
}

struct GithubSearchOwner: Decodable, Hashable {
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
