//
//  LocationFavoriteViewModel.swift
//  CamPlace
//
//  Created by Chung Wussup on 7/5/24.
//

import Foundation
import Combine

class LocationFavoriteViewModel {
    @Published var locations: [Location] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        bindData()
    }
    
    private func bindData() {
        CoreDataManager.shared.$locations
            .sink { [weak self] locations in
                self?.locations = locations
            }
            .store(in: &cancellables)
    }
}
