//
//  ContentView.swift
//  FlickrImages
//
//  Created by Abhishek Khapare on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FlickrImagesSearchableView(viewModel: FlickrImagesViewModel())
    }
}
