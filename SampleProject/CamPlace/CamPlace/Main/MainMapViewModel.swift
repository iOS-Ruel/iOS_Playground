//
//  MainMapViewModel.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import Foundation
import Combine

class MainMapViewModel {
    private let service = MainMapViewService()
    private var cancellables = Set<AnyCancellable>()
    @Published var locationList: [LocationBasedListModel] = []
    @Published var errorMessage: String?
    
    func getLocationList(mapX: String, mapY: String, radius: String) {
        service.getLocationBasedList(mapX: mapX, mapY: mapY, radius: radius,
                                     type: LocationBasedListModel.self)
            .map { $0.response.body.items.item }
            .catch { [weak self] error -> Just<[LocationBasedListModel]> in
                self?.errorMessage = error.localizedDescription
                 return Just([])
            }
            .assign(to: \.locationList, on: self)
            .store(in: &cancellables)
    }
    
    
    
    func getLocationContent(title: String) -> LocationBasedListModel? {
        
        if let firstIndex = locationList.firstIndex(where: { $0.title == title }) {
            return locationList[firstIndex]
        }
        
        return nil
    }
}
