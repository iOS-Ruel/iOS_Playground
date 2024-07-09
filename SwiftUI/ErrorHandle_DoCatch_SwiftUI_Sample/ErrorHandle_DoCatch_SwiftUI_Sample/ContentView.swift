//
//  ContentView.swift
//  ErrorHandle_DoCatch_SwiftUI_Sample
//
//  Created by Chung Wussup on 7/9/24.
//

import SwiftUI

enum MajorProblems: Error {
    case divideByZero
    case noNegativeNumberPlease
}

struct ContentView: View {
    @State var message = ""
    @State var numeratorSlider: Float = 0.0
    @State var denominatorSlider: Float = 0.0
    
    var body: some View {
        VStack {
            HStack {
                Text("Numerator = \(numeratorSlider)")
                Slider(value: $numeratorSlider, in: -20...20, step:1.0)
            }
            HStack {
                Text("Denominator = \(denominatorSlider)")
                Slider(value: $denominatorSlider, in: -20...20, step:1.0)
            }
            Button {
                divideFunction(numerator: Double(numeratorSlider), denominator: Double(denominatorSlider))
            } label: {
                 Text("Divide")
            }
            
            Text(message)
                    }
        .padding()
    }
    
    
    func divideFunction(numerator: Double, denominator: Double) {
        do {
            try checkMe(top: numerator, bottom: denominator)
            message = "Answer = \(numerator / denominator)"
        } catch MajorProblems.divideByZero{
            message = "Can't divide by zero"
        } catch MajorProblems.noNegativeNumberPlease {
            message = "No negative numbers, please"
        } catch {
            message = "Some other error occurred"
        }
    }
    func checkMe(top: Double, bottom: Double) throws {
        guard bottom != 0 else {
            throw MajorProblems.divideByZero
        }
        guard top >= 0 && bottom > 0 else {
            throw MajorProblems.noNegativeNumberPlease
        }
    }

}

#Preview {
    ContentView()
}
