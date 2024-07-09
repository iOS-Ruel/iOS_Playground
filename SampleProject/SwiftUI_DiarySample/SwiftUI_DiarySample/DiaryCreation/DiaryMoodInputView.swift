//
//  DiaryMoodInputView.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import SwiftUI

struct DiaryMoodInputView: View {
    
    
    //앞에 뷰에서 받아온 vm
    @ObservedObject var vm: DiaryViewModel
    let moods: [Mood] = Mood.allCases
    
    var body: some View {
        
        VStack {
            Spacer()
            
            HStack {
                ForEach(moods, id: \.self) { mood in
                    Button {
                        vm.mood = mood
                    } label: {
                        VStack {
                            Image(systemName: mood.imageName)
                                .resizable()
                                .renderingMode(.original)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                                .shadow(color: .black.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                                .padding()
                            
                            Text(mood.name)
                                .foregroundColor(.gray)
                        }
                        .frame(height: 180)
                        .background(mood == vm.mood ? .gray.opacity(0.4) : .clear)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            NavigationLink {
                DiaryTextInputView(vm: vm)
            } label: {
                Text("Next")
                    .frame(width: 200, height: 80)
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(40)
            }
        }
    
    }
}

#Preview{
    DiaryMoodInputView(vm: DiaryViewModel(isPresented: .constant(false),
                                          diaries: .constant(MoodDiary.list)))
}
