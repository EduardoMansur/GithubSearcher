//
//  SearchView.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelType>: View {
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
        
    }
    
    var body: some View {
        loadedList()
        .searchable(text: $viewModel.searchText)
        .task(id: viewModel.searchText) {
            do {
                try await Task.sleep(for: .seconds(0.5))
                await viewModel.search(text: viewModel.searchText)
            } catch {
                print("The task was canceled.")
            }
        }
    }
    
    @ViewBuilder
    func loadedList() -> some View {
        List {
            switch viewModel.state {
            case .initial:
                welcomeMessage()
            case .error(let error):
                errorMessage(error: error)
            case .loading:
                loadingMessage()
            case .noResults:
                noResultMessage()
            case .loaded:
                ForEach(viewModel.searchItems) { item in
                    NavigationLink(value: Route.details(repo: item)) {
                        SearchResultCell(viewModel: SearchResultCellViewModel(githubItem: item))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func welcomeMessage() -> some View {
        Text("Welcome, please search for a keyword")
    }
    
    @ViewBuilder
    func errorMessage(error: Error) -> some View {
        Text(error.localizedDescription)
    }

    @ViewBuilder
    func loadingMessage() -> some View {
        ProgressView().id(UUID())
    }
    
    @ViewBuilder
    func noResultMessage() -> some View {
        Text("No result")
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(repository: SearchResultRepository()))
}
