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
    @Published var cellType: [DetailCellType] = []
    
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    
    init(content: LocationBasedListModel) {
        self.content = content
        getImageList()
        bindContent()
    }

    private func bindContent() {
        $imageList
            .map { [weak self] images -> [DetailCellType] in
                var cellTypes: [DetailCellType] = []
                cellTypes.append(.image(imageUrls: images.compactMap { $0.imageUrl }.filter { !$0.isEmpty }))
                if let content = self?.content {
                    cellTypes.append(.info(content: content))
                    cellTypes.append(.map(mapX: content.mapX ?? "", 
                                          mapY: content.mapY ?? "",
                                          titleWithAdress: "\(content.title ?? "")\n\(content.subTitle ?? "")"))
                }
                return cellTypes
            }
            .assign(to: \.cellType, on: self)
            .store(in: &cancellables)
    }
    
    private func getImageList() {
           service.getLocationImageList(contentId: content.contentId, type: ImageListModel.self)
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
}
