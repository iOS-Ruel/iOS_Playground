//
//  ContentView.swift
//  Photos_SwiftUI_Sample
//
//  Created by Chung Wussup on 7/8/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    var body: some View {
        VStack {
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .foregroundStyle(.gray)
            }
            
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                Text("Select a Photo")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .presentationCornerRadius(10)
            }
        }
        .padding()
        .onChange(of: selectedItem) { oldValue, newValue in
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
                    
            }
        }
    }
}

#Preview {
    ContentView()
}
