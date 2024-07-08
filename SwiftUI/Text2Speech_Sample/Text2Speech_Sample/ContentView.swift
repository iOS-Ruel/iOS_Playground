//
//  ContentView.swift
//  Text2Speech_Sample
//
//  Created by Chung Wussup on 7/8/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    let audio = AVSpeechSynthesizer()
    
    @State var convertText = AVSpeechUtterance(string: "")
    @State var textToRoad = "This is a test of the emergency broadcast system"
    @State var sliderValue: Float = 0.0
    
    var body: some View {
        VStack {
            TextEditor(text: $textToRoad)
                .frame(width: 250, height: 200)
            Slider(value: $sliderValue, in: 0...1)
            
            Button {
                convertText = AVSpeechUtterance(string: textToRoad)
                convertText.rate = sliderValue
                
                //https://gist.github.com/Koze/d1de49c24fc28375a9e314c72f7fdae4
//                let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Ellen-compact")
                let voice = AVSpeechSynthesisVoice(language: "en-AU")
                convertText.voice = voice

                audio.speak(convertText)
            } label : {
                Text("Read Text Out Loud")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
