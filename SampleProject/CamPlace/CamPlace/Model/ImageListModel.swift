//
//  ImageListModel.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import Foundation


struct ImageListModel: Codable {
    let contentId: String
    let serialnum: String
    let imageUrl: String
    let createdtime: String
    let modifiedtime: String
}
