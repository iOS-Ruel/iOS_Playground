//
//  ContentView.swift
//  ErrorHandle_Guard_SwiftUI_Sample
//
//  Created by Chung Wussup on 7/9/24.
//

import SwiftUI

struct ContentView: View {
    @State var showImage: UIImage = UIImage(systemName: "photo")!
    
    var body: some View {
        VStack {
            Image(uiImage: showImage)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 400)
            
            Button {
                getImage("xyg")
            } label: {
                Text("Add Picutre")
            }
        }
        .padding()
    }
    
    func getImage(_ imageName: String) {
        //전통적 방법
        if UIImage(named: imageName) != nil {
            showImage = UIImage(named: imageName)!
        } else {
            showImage = UIImage(systemName: "xmark.octagon.fill")!
        }
        
        //guard
        guard let image = UIImage(named: imageName) else {
            showImage = UIImage(systemName: "xmark.octagon.fill")!
            return
        }
        showImage = image
        
        //guard 2
        guard UIImage(named: imageName) != nil else {
            showImage = UIImage(systemName: "xmark.octagon.fill")!
            return
        }
        showImage = UIImage(named: imageName)!
        
    }
}

#Preview {
    ContentView()
}
