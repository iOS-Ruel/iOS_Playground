//
//  DiaryDetailsView.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import SwiftUI

struct DiaryDetailsView: View {
    
    @StateObject var vm: DiaryDetailsViewModel
    @Environment(\.colorScheme) var  colorScheme
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 5) {
                    Text(formattedDate(dateString: vm.diary.date))
                        .font(.system(size: 30, weight: .bold))

                    Image(systemName: vm.diary.mood.imageName)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                        .frame(height: 80)
                    
                    Text(vm.diary.text)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
            
            HStack {
                Button {
                    print("delete button tapped")
                    vm.delete()
                } label: {
                    Image(systemName: "trash")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
                
                Spacer()

            }
        }
        
        
        
    }
}

extension DiaryDetailsView {
    private func formattedDate(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = formatter.date(from: dateString)
        
        formatter.dateFormat = "EEE, MMM d, yyyy"
        return formatter.string(from: date!)
    }
}

#Preview {
    DiaryDetailsView(vm: DiaryDetailsViewModel(diaries: .constant(MoodDiary.list), diary: MoodDiary.list.first!))
}
