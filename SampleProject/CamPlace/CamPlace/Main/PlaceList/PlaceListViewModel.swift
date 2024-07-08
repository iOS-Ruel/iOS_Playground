//
//  PlaceListViewModel.swift
//  CamPlace
//
//  Created by Chung Wussup on 7/8/24.
//

import Foundation
import Combine

class PlaceListViewModel {
    @Published var locationList: [LocationBasedListModel]
    private var cancellables = Set<AnyCancellable>()
    
    init(locationList: [LocationBasedListModel]) {
        self.locationList = locationList
    }
    
    func locationListCount() -> Int {
        return locationList.count
    }
    
    func getLocation(index: Int) -> LocationBasedListModel {
        return locationList[index]
    }
    
}
