//
//  MoodDiaryCell.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import SwiftUI

struct MoodDiaryCell: View {
    var diary: MoodDiary
    @Environment(\.colorScheme) var  colorScheme
    
    var body: some View {
        VStack(spacing: 10) {
            Text(dateSetting(date: diary.date))
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                
            
            Image(systemName: diary.mood.imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: .black.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        }
        
    }
    
    func dateSetting(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        guard let date = dateFormatter.date(from: date) else { return "일" }
        
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return "\(day) 일"
        
        
        
    }
}

#Preview {
    MoodDiaryCell(diary: MoodDiary.list.first!)
}
