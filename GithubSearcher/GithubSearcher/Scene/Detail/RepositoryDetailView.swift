//
//  RepositoryDetailView.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//


import SwiftUI

struct RepositoryDetailView<ViewModel: RepositoryDetailViewModelType>: View {
    
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    profileSection
                    descriptionSection
                    StatRowView(icon: "star.fill", iconColor: .yellow, title: "Stars", value: $viewModel.stars)
                    StatRowView(icon: "tuningfork", iconColor: .blue, title: "Forks", value: $viewModel.forked)
                    StatRowView(icon: "clock", iconColor: .gray, title: "Last updated", value: $viewModel.lastUpdated)
                    linkSection()
                }
                .padding()
                .environment(\.openURL, OpenURLAction { url in
                           .systemAction(prefersInApp: true)
                       })
            }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var profileSection: some View {
        HStack(spacing: 16) {
            AsyncImage(url: viewModel.avatarURL) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 50)
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .clipShape(Circle())
            .clipped()
            
            Text(viewModel.title)
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .padding(.bottom, 20)
            
            Group {
                Text(viewModel.description)
            }
            .font(.system(size: 15))
            .foregroundColor(.gray)
            .lineSpacing(4)
        }
    }
    
    @ViewBuilder
    private func linkSection() -> some View {
        if let url = viewModel.linkURL {
            Link("Website", destination: url)
                .font(.headline)
                .foregroundStyle(.blue)
        }
    }
}
