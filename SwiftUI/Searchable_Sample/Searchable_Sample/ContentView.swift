//
//  ContentView.swift
//  Searchable_Sample
//
//  Created by Chung Wussup on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    
    let petArray = ["Cat", "Dog", "Fish", "Donkey", "Canary", "Camel", "Frog"]
    
    var body: some View {
        NavigationStack {
            PetListView(animals: petArray)
        }
        .navigationBarTitleDisplayMode(.automatic)
        .searchable(text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Look for a pet") {
            
            //제안하는 키워드가 있을때 사용
            Text("Singing").searchCompletion("Canary")
            Text("Croaking").searchCompletion("Frog")
            Text("Grumpy").searchCompletion("Cat")
            
            Divider()
            //SearchText 가 비어있을 경우, hasPrefix는 true를 리턴
            //배열의 모든 요소가 출력됨
            ForEach(petArray.filter {
                $0.hasPrefix(searchText)
            }, id: \.self) { name in
                Text(name)
            }
        }
    }
}


#Preview {
    ContentView()
}

struct PetListView: View {
    let animals: [String]
    
    var body: some View {
        List(animals, id: \.self) { animal in
            Text(animal)
        }
        .listStyle(.plain)
    }
}
