//
//  Post.swift
//  Socially-UIKit
//
//  Created by Chung Wussup on 7/25/24.
//

import Foundation
import FirebaseFirestore

struct Post: Hashable, Identifiable, Decodable {
    @DocumentID var id: String?
    var description: String?
    var imageURL: String?
    @ServerTimestamp var datePublished: Date?
}
