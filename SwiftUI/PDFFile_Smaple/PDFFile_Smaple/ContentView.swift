//
//  ContentView.swift
//  PDFFile_Smaple
//
//  Created by Chung Wussup on 7/8/24.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    let fileUrl = Bundle.main.url(forResource: "example", withExtension: "pdf")
    var body: some View {
        VStack {
            ViewMe(url: fileUrl!)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


struct ViewMe: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<ViewMe>) -> some PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
