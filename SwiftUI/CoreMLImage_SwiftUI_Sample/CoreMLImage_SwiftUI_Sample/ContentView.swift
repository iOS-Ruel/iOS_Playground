//
//  ContentView.swift
//  CoreMLImage_SwiftUI_Sample
//
//  Created by Chung Wussup on 7/9/24.
//

import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    
    @State var message = ""
    @State var arrayIndex = 0
    @State var image: UIImage = UIImage(named: "cat")!
    
    let photoArray = ["cat", "plane", "banana", "car"]
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            TextEditor(text: $message)
                .padding()
            Button {
                useAI(sentImage: photoArray[arrayIndex])
            } label: {
                Text("Analyze Image")
            }.padding()
            
            HStack {
                Button {
                    if arrayIndex == 0 {
                        arrayIndex = photoArray.count - 1
                    } else {
                        arrayIndex -= 1
                    }
                    message = ""
                    image = UIImage(named: photoArray[arrayIndex])!
                } label: {
                    Image(systemName: "chevron.left.square.fill")
                }
                Button {
                    if arrayIndex == photoArray.count - 1 {
                        arrayIndex = 0
                    } else {
                        arrayIndex += 1
                    }
                    message = ""
                    image = UIImage(named: photoArray[arrayIndex])!
                } label: {
                    Image(systemName: "chevron.right.square.fill")
                }
            }
        }
        .padding()
    }
    
    func useAI(sentImage: String) {
//        guard let imagePath = Bundle.main.path(forResource: sentImage, ofType: "jpg") else {
//            print(sentImage)
//            message = "Image Not Found"
//            return
//        }
//        
//        let imageURL = NSURL.fileURL(withPath: imagePath)
        
        guard let uiImage = UIImage(named: sentImage) else {
            print(sentImage)
            message = "Image Not Found"
            return
        }
        
        guard let cgImage = uiImage.cgImage else {
            message = "Failed to convert UIImage to CGImage"
            return
        }
        
        
//        let modelFile = try? MobileNetV2(configuration: MLModelConfiguration())
        let modelFile = try? SqueezeNet(configuration: MLModelConfiguration())
        let model = try! VNCoreMLModel(for: modelFile!.model)
        

        let handler = VNImageRequestHandler(cgImage: cgImage)

        
        let request = VNCoreMLRequest(model: model, completionHandler: findResults)
        
        try! handler.perform([request])
    }
    
    func findResults(request: VNRequest, error: Error?) {
        guard let result = request.results as? [VNClassificationObservation] else {
            fatalError("Unable to get results")
        }
        var bestGuess = ""
        var bestConfidence: VNConfidence = 0
        
        
        for classification in result {
            if classification.confidence > bestConfidence {
                bestConfidence = classification.confidence
                bestGuess = classification.identifier
            }
        }
        
        message = "Image is: \(bestGuess) with confidence \(bestConfidence)"
    }
    
}

#Preview {
    ContentView()
}
