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
        List(viewModel.searchItems) { item in
            SearchResultCell(viewModel: SearchResultCellViewModel(githubItem: item))
        }
        .searchable(text: $viewModel.searchText)
        .task(id: viewModel.searchText) {
            do {
                try await Task.sleep(for: .seconds(0.5))
                try await viewModel.search(text: viewModel.searchText)
            } catch {
                print("error on search \(error.localizedDescription)")
            }
        }
        .padding()
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(repository: SearchResultRepository()))
}
