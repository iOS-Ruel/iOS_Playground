//
//  DiaryDateInputView.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import SwiftUI

struct DiaryDateInputView: View {
        
    @StateObject var vm: DiaryViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                DatePicker("Start Date",
                           selection: $vm.date,
                           displayedComponents: [.date])
                .datePickerStyle(.graphical)
                
                Spacer()
                
                NavigationLink {
                    DiaryMoodInputView(vm: vm)
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
}

#Preview {

    DiaryDateInputView(vm: DiaryViewModel(isPresented: .constant(false),
                                          diaries: .constant(MoodDiary.list)))
}
