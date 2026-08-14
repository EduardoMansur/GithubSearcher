//
//  SearchResultCell.swift
//  GithubSearcher
//
//  Created by Eduardo Torres Mansur Pereira on 14/08/26.
//

import SwiftUI
struct SearchResultCell<ViewModel: SearchResultCellViewModel>: View {
    @State var viewModel: ViewModel
    
    struct Layout {
        static var imageSize: CGFloat { 50 }
    }
    
    init(viewModel: ViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            profilePicture()
            VStack(alignment: .leading) {
                repositoryName()
                description()
                stars()
            }
        }
        .padding()
    }
    
    // MARK: - Views
    
    @ViewBuilder
    func profilePicture() -> some View {
        AsyncImage(url: viewModel.ownerAvatar) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .clipShape(Circle())
        .clipped()
        .frame(width: Layout.imageSize, height: Layout.imageSize)
        .padding()
    }
    
    @ViewBuilder
    func stars() -> some View {
        Label(viewModel.numberOfStars, systemImage: "star.fill")
    }
    
    @ViewBuilder
    func repositoryName() -> some View {
        Text(viewModel.repositoryName)
            .font(.headline)
    }
    
    @ViewBuilder
    func description() -> some View {
        Text(viewModel.description)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}

#Preview {
    SearchResultCell(viewModel: SearchResultCellViewModel(repositoryName: "Text name", description: "Text Description", numberOfStars: "55", ownerAvatar: URL(string: "https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?90af0c8")!))
}
