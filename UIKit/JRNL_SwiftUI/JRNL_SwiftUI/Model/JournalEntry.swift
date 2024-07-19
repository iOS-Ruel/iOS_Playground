//
//  JournalEntry.swift
//  JRNL_SwiftUI
//
//  Created by Chung Wussup on 5/28/24.
//

import Foundation
import SwiftData
import UIKit

@Model
class JournalEntry {
    
    let date: Date
    let rating: Int
    let entryTitle: String
    let entryBody: String
    let latitude: Double?
    let longitude: Double?
    @Attribute(.externalStorage) let photoData: Data?
    
    init(rating: Int, entryTitle: String, entryBody: String, latitude: Double?, longitude: Double?, photo: UIImage?) {
        self.date = Date()
        self.rating = rating
        self.entryTitle = entryTitle
        self.entryBody = entryBody
        self.latitude = latitude
        self.longitude = longitude
        self.photoData = photo?.jpegData(compressionQuality: 1.0)
    }
    
    @Transient
    var photo: UIImage? {
        if let data = photoData {
            return UIImage(data: data)
        }
        return nil
    }
    
}
