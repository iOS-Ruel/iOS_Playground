//
//  ContentView.swift
//  SwiftUI_SimpleView
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

private class PersonViewModel: ObservableObject {
    @Published var firstNmae = ""
    @Published var lastName = ""
    
    func save() {
        print("Save To Disk")
    }
    
}

struct ContentView: View {
    @State var message = ""
    @State var dirty = false
    @StateObject private var viewModel = PersonViewModel()
    
    var body: some View {
        Form {
            Section("\(self.dirty ? "*" : "") Input fields") {
                TextField("First Name", text: $viewModel.firstNmae)
                    .onChange(of: viewModel.firstNmae) {
                        self.dirty = true
                    }
                    .onSubmit {
                        viewModel.save()
                        self.dirty = false
                    }
                TextField("Last Name", text: $viewModel.lastName)
                    .onChange(of: viewModel.lastName) {
                        self.dirty = true
                    }
                    .onSubmit {
                        viewModel.save()
                        self.dirty = false
                    }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
