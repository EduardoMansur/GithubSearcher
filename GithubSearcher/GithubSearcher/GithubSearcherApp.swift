//
//  GithubSearcherApp.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import SwiftUI

@main
struct GithubSearcherApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SearchView(viewModel: SearchViewModel(repository: SearchResultRepository()))
                    .navigationTitle("Search")
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .details(let repo):
                            RepositoryDetailView(viewModel: RepositoryDetailViewModel(repo: repo))
                        }
                    }
            }
        }
    }
}

enum Route: Hashable {
    case details(repo: GithubSearchItem)
}
