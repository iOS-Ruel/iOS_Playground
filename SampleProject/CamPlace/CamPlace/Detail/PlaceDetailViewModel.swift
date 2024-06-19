//
//  PlaceDetailViewModel.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/19/24.
//

import Foundation
import Combine

class PlaceDetailViewModel {
    private let content: LocationBasedListModel
    private let service = PlaceDetailService()
    
    @Published var imageList = [ImageListModel]()
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    
    init(content: LocationBasedListModel) {
        self.content = content
        getImageList()
    }

    private func getImageList() {
        let contentId = content.contentId
        service.getLocationImageList(contentId: contentId, type: ImageListModel.self)
            .map { $0.response.body.items.item }
            .catch { [weak self] error -> Just<[ImageListModel]> in
                self?.errorMessage = error.localizedDescription
                return Just([])
            }
            .assign(to: \.imageList, on: self)
            .store(in: &cancellables)
    }
    
    func getContentTitle() -> String {
        return content.title ?? ""
    }
    
    func getContent() -> LocationBasedListModel {
        return content
    }
    
    func getMapY() -> String {
        return content.mapY ?? ""
    }
    
    func getMapX() -> String {
        return content.mapX ?? ""
    }
    
    func getTitle() -> String {
        return "\(content.title ?? "")\n\(content.subTitle ?? "")"
    }
    
    
    func getImages() -> [String] {
        return imageList.compactMap { $0.imageUrl }.filter { !$0.isEmpty }
    }
}
