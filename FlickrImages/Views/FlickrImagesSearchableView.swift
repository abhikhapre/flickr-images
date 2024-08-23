//
//  FlickerImagesSearchableView.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import SwiftUI

struct FlickrImagesSearchableView: View {
    private enum Layout {
        static let minimum: CGFloat = 100.0
        static let gridSpacing: CGFloat = 5.0
        static let imageAspectRatio: CGFloat = 1.0
        static let gridHorizontalPadding: CGFloat = 5.0
    }
    
    @State private var searchText: String = ""
    @ObservedObject var viewModel: FlickrImagesViewModel
    
    @Namespace var namespace
    
    var body: some View {
        NavigationView {
            ZStack {
                if searchText.isEmpty {
                    Text(viewModel.placeholderText)
                        .foregroundColor(Color.gray)
                }
                
                if case .failure = viewModel.flickrImagesDataResult {
                    Text(viewModel.apiFailureError)
                        .foregroundColor(Color.gray)
                }
                
                imagesGridView()
            }
            .navigationTitle(viewModel.navigationTitle)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .task(id: searchText) {
            await viewModel.getImages(searchText: searchText)
        }
    }
}

extension FlickrImagesSearchableView {
    @ViewBuilder
    private func imagesGridView() -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [.init(.adaptive(minimum: Layout.minimum,
                                                maximum: .infinity),
                                      spacing: Layout.gridSpacing)],
                      spacing: Layout.gridSpacing) {
                ForEach(viewModel.flickrImagesDataModel?.items ?? [], id: \.link) { item in
                    
                    NavigationLink {
                        withAnimation {
                            FlickrImageDetailsView(imageItem: item)
                                .environmentObject(viewModel)
                        }
                    } label: {
                        asyncImageView(item)
                            .accessibilityHint("Double tap this thumbnail to navigate to the details view")
                    }
                }
            }
                      .padding(.horizontal, Layout.gridHorizontalPadding)
        }
    }
    
    @ViewBuilder
    private func asyncImageView(_ item: FlickrImagesServerDataModel.FlickrImageItem) -> some View {
        AsyncImage(url: viewModel.getImageURL(item)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero,  maxHeight: .infinity)
                .clipped()
                .border(.gray)
                .aspectRatio(Layout.imageAspectRatio, contentMode: .fit)
                .matchedGeometryEffect(id: item.title, in: namespace)
        } placeholder: {
            ProgressView()
        }
    }
}
