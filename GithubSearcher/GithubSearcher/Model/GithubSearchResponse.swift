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

struct GithubSearchItem: Decodable, Identifiable {
    let id: String
    let name: String
    let htmlURL: String
    let description: String?
    let stars: Int
    let owner: GithubSearchOwner
    
    enum CodingKeys: String, CodingKey {
        case name, htmlURL, description, owner, id
        case stars = "stargazers_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresentWithMetrics(String.self, forKey: .name, defaultValue: "no name")
        self.id = try container.decodeIfPresentWithMetrics(String.self, forKey: .id, defaultValue: UUID().uuidString)
        self.htmlURL = try container.decodeIfPresentWithMetrics(String.self, forKey: .htmlURL, defaultValue: "no htmlURL")
        self.description = try container.decodeIfPresentWithMetrics(String.self, forKey: .description, defaultValue: "no description")
        self.owner = try container.decode(GithubSearchOwner.self, forKey: .owner)
        self.stars = try container.decodeIfPresentWithMetrics(Int.self, forKey: .stars, defaultValue: 0)
    }
    
}

extension KeyedDecodingContainer {
    public func decodeIfPresentWithMetrics<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key, defaultValue: T) throws -> T where T : Decodable {
        if let string = try? self.decodeIfPresent(T.self, forKey: key) {
            return string
        } else {
            debugPrint("Error decoding \(type)) for key: \(key)")
            return defaultValue
        }
    }
}

struct GithubSearchOwner: Decodable {
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
