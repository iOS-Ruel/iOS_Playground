//
//  ContentView.swift
//  ReadWrite_FileAccess_Sample
//
//  Created by Chung Wussup on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var createText = ""
    @State var displayText = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $createText)
            HStack {
                Button {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        try createText.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        print("File writing error")
                    }
                    
                } label: {
                    Text("Write File")
                }
                
                Button {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        let fileContent = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                        displayText = fileContent
                    } catch {
                        print("File Reading Error")
                    }
                } label: {
                    Text("Read File")
                }

            }
            .padding()
            TextEditor(text: $displayText)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
