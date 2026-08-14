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
        .onChange(of: viewModel.searchText) { _, newValue in
            viewModel.search(text: newValue)
        }
        .padding()
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
