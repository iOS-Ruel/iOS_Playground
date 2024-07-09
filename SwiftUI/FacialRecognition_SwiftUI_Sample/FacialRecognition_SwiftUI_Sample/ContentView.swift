//
//  ContentView.swift
//  FacialRecognition_SwiftUI_Sample
//
//  Created by Chung Wussup on 7/9/24.
//

import SwiftUI
import Vision

struct ContentView: View {
    
    let photoArray =  ["image1", "image2", "image3"]
    
    @State var message = ""
    @State var arrayIndex = 0
    @State var analyzedImage: UIImage?

    var body: some View {
        VStack {
            if let image = analyzedImage {
                Image(uiImage: image)
                    .resizable()
                    .blur(radius: 2)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 500)
            } else {
                Image(photoArray[arrayIndex])
                    .resizable()
                    .blur(radius: 5)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 500)
            }
            Text(message)
                .padding()
            Button {
                analyzeImage(image: UIImage(named: photoArray[arrayIndex])!)
            } label: {
                Text("Analyze Image")
            }.padding()

            HStack {
                Spacer()
                Button {
                    if arrayIndex == 0 {
                        arrayIndex = photoArray.count - 1
                    } else {
                        arrayIndex -= 1
                    }
                    message = ""
                    analyzedImage = nil
                } label: {
                    Image(systemName: "chevron.left.square.fill")
                        .font(.largeTitle)
                }
                Spacer()
                Button {
                    if arrayIndex == photoArray.count - 1 {
                        arrayIndex = 0
                    } else {
                        arrayIndex += 1
                    }
                    message = ""
                    analyzedImage = nil
                } label: {
                    Image(systemName: "chevron.right.square.fill")
                        .font(.largeTitle)
                }
                Spacer()
            }
        }
        .padding()
    }
    
    func analyzeImage(image: UIImage) {
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNDetectFaceLandmarksRequest(completionHandler: handleFaceRecognition)
        try! handler.perform([request])
    }
    
    func handleFaceRecognition(request: VNRequest, error: Error?) {
        guard let foundFaces = request.results as? [VNFaceObservation] else {
            fatalError("Can't find a face in the picture")
        }
        message = "Found \(foundFaces.count) faces in the picture"
        
        guard let image = UIImage(named: photoArray[arrayIndex]) else { return }
        
        // 이미지 생성을 위한 컨텍스트 시작
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)

        // 컨텍스트 변수 가져오기
        let context = UIGraphicsGetCurrentContext()!
                
        // 컨텍스트 내에 이미지 그리기
        image.draw(in: CGRect(origin: .zero, size: image.size))
        
        // 이미지를 그린 후 좌표계를 변환합니다.
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        // 얼굴 주변 사각형을 그리기 위한 선 색상과 두께 설정
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)

        for faceObservation in foundFaces {
            // 정규화 된 얼굴 인식 위치값(CGRect) 가져오기
            let faceRect = VNImageRectForNormalizedRect(faceObservation.boundingBox, Int(image.size.width), Int(image.size.height))
            // 가져온 위치에 테두리 그리기
            context.stroke(faceRect)
        }
        // 컨텍스트를 종료하고, 컨텍스트 결과를 이미지 변수에 할당
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // 커밋 (위의 컨텍스트 명령을 실행함)
        UIGraphicsEndImageContext()
        
        // 만들어진 이미지를 화면에 출력
        analyzedImage = newImage
    }
}

#Preview {
    ContentView()
}
