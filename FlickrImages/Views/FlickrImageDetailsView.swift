//
//  FlickrImageDetailsView.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import SwiftUI

struct FlickrImageDetailsView: View {
    private enum Layout {
        static let imageViewBottomPadding: CGFloat = -50.0
        static let vStackSpacing: CGFloat = 20.0
        static let imageLineWidth: CGFloat = 4.0
        static let imageShadowRadius: CGFloat = 7.0
    }
    
    let imageItem: FlickrImagesServerDataModel.FlickrImageItem
    @EnvironmentObject var viewModel: FlickrImagesViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                imageView()
                    .offset(y: Layout.imageViewBottomPadding)
                    .padding(.bottom, Layout.imageViewBottomPadding)
                    .accessibilityLabel(Text("Image: \(imageItem.title ?? "")"))
                
                VStack(alignment: .leading, spacing: Layout.vStackSpacing) {
                    imageItem.title.map { title in
                        Text(title)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: Layout.vStackSpacing) {
                        imageItem.author.map { author in
                            Text("Author: \(author)")
                        }
                        
                        Divider()
                        
                        viewModel.getFormattedDate(imageItem.published).map { publishedDate in
                            Text("Published date: \(publishedDate)")
                        }
                    }
                    .font(.subheadline)
                    
                    Divider()
                    
                    if let description = imageItem.title {
                        Text("Description:")
                            .font(.title3)
                        
                        HTMLText(htmlString: description)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

extension FlickrImageDetailsView {
    @ViewBuilder
    private func imageView() -> some View {
        if let imageURL = imageItem.media?.imageURL {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: Layout.imageLineWidth)
                    }
                    .shadow(radius: Layout.imageShadowRadius)
            } placeholder: {
                ProgressView()
            }
        }
    }
}
