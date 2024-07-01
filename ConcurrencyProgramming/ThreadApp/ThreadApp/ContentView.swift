//
//  ContentView.swift
//  ThreadApp
//
//  Created by Chung Wussup on 7/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var message: String = ""
    @State var results: String = ""
    @State var sliderValue: Double = 0.0
    
    
    var body: some View {
        VStack {
            Button("Click Me") {
                let startTime = NSDate()
                let fetchedData = fetchSomethingFromServer()
                let processedData = processData(fetchedData)
                let firstResult = calculateFirstResult(processedData)
                let secondResult = calculateSecondResult(processedData)
                
                let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
                results = resultsSummary
                
                let endTime = NSDate()
                message = "Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds."
                
            }
            TextEditor(text: $results)
            Slider(value: $sliderValue)
            Text("Message = \(message)")
        }
        .padding()
    }
    
    
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: TimeInterval(1))
        return "Hi There"
    }
    
    func processData(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
}

#Preview {
    ContentView()
}
