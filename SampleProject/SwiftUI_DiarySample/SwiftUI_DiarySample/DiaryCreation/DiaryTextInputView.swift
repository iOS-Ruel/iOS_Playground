//
//  DiaryTextInputView.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import SwiftUI

struct DiaryTextInputView: View {
    
    //앞에 뷰에서 받아온 vm
    @ObservedObject var vm: DiaryViewModel
    
    @FocusState var focused: Bool
    
    
    var body: some View {
        VStack {
            TextEditor(text: $vm.text)
                .focused($focused)
                .border(.gray.opacity(0.2), width: 2)
                
            
            Spacer()
            
            Button {
                vm.completed()
            } label: {
                Text("Done")
                    .frame(width: 200, height: 80)
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(40)
                
            }
        }
        .padding()
        .onAppear {
            focused = true
        }
    }
}

#Preview {
    DiaryTextInputView(vm: DiaryViewModel(isPresented: .constant(false),
                                          diaries: .constant(MoodDiary.list)))
}
