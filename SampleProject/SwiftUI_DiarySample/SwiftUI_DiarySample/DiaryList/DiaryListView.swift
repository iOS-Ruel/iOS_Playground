//
//  DiaryListView.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import SwiftUI

struct DiaryListView: View {
    //월별로 섹션을 나눔
    
    @StateObject var vm: DiaryListViewModel
    //presenting
    @State var isPresenting: Bool = false
    
    let layout:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
         ]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                //그리드 형태 layout 개수에 맞춰서 그리기
                ScrollView {
                    LazyVGrid(columns:layout) {
                        //vm.keys에 header를 Key로 맞춰서 그리기
                        ForEach(vm.keys, id: \.self) { key in
                            //section vm.dic[key]의 배열을 가지고 sort 후 sort된 아이템으로 cell그리기
                            Section {
                                let items = vm.dic[key] ?? []
                                let orderedItems = items.sorted(by: {$0.date<$1.date})
                                
                                ForEach(orderedItems) { item in
                                    NavigationLink {
                                        let vm = DiaryDetailsViewModel(diaries: $vm.list, diary: item)
                                        DiaryDetailsView(vm: vm)
                                    } label: {
                                        MoodDiaryCell(diary: item)
                                            .frame(height: 50)
                                    }
                                }
                                
                            } header: {
                                HStack {
                                    Text(formattedSectionTitle(key))
                                        .font(.system(size: 30, weight: .black))
                                    Spacer()
                                }
                                
                            }
                            .frame(height: 60)
                            .padding()
                        }
                    }
                }
                
                HStack {
                    Button {
                        print("new button tapped")
                        isPresenting = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                    }
                    .frame(width: 80,height: 80)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(40)
                }
            }
            .navigationTitle("Emotion Diary")
        }
        .sheet(isPresented: $isPresenting) {
            let vm = DiaryViewModel(isPresented: $isPresenting, diaries: $vm.list)
            DiaryDateInputView(vm: vm)
        }
        .onAppear {
            vm.fetch()
        }
        
    }
}


extension DiaryListView {
    private func formattedSectionTitle(_ id: String) -> String {
        let dateComponents = id
            .components(separatedBy: "-")
            .compactMap { Int($0) }
        guard let year = dateComponents.first, let month = dateComponents.last else { return id
        }
        
        let calendar = Calendar(identifier: .gregorian)
        let dateComponent = DateComponents(calendar: calendar, year: year, month: month)
        let date = dateComponent.date!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}


#Preview {
    DiaryListView(vm: DiaryListViewModel(storage: MoodDiaryStorage()))
}

