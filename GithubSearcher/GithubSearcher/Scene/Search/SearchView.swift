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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
