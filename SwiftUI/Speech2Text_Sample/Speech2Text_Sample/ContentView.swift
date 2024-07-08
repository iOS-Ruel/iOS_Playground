//
//  ContentView.swift
//  Speech2Text_Sample
//
//  Created by Chung Wussup on 7/8/24.
//

import SwiftUI
import Speech

struct ContentView: View {
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    
    @State var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State var recognitionTask: SFSpeechRecognitionTask?
    
    @State var message = ""
    @State var buttonStatus = true
    @State var newColor: Color = .white
    
    
    var body: some View {
        //        VStack {
        //            TextEditor(text: $message)
        //                .frame(width: 300, height: 400)
        //            Button(buttonStatus ? "Start recording" : "Stop Recording") {
        //                buttonStatus.toggle()
        //
        //                if buttonStatus {
        //                    stopRecording()
        //                } else {
        //                    startRecording()
        //                }
        //            }
        //            .padding()
        //            .background(buttonStatus ? Color.green : Color.red)
        //        }
        //        .padding()
        VStack (spacing: 25) {
            Button { startRecording()
            } label: {
                Text("Start recording") }
            TextField("Spoken text appears here", text: $message)
            Button {
                message = ""
                newColor = .white
                stopRecording()
            } label: {
                Text("Stop recording")
            } }.background(newColor)
    }
    
    func checkSpokenCommand (commandString: String) {
        switch commandString {
            
        case "보라":
            newColor = .purple
        case "초록":
            newColor = .green
        case "노랑":
            newColor = .yellow
        default:
            newColor = .white
        }
    }
     
    
    func startRecording() {
        message = "start recording"
        let node = audioEngine.inputNode
        //저장공간
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        recognitionRequest?.shouldReportPartialResults = true
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffet, _) in
            recognitionRequest?.append(buffet)
        }
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let recognizeMe = SFSpeechRecognizer() else {
            return
        }
        if !recognizeMe.isAvailable { return
        }
        
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest ?? SFSpeechAudioBufferRecognitionRequest.init(), resultHandler: { result, error in
            if let result = result {
                let transcrinbedString = result.bestTranscription.formattedString
                message = transcrinbedString
                checkSpokenCommand(commandString: transcrinbedString)
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionTask?.cancel()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
    }
}

#Preview {
    ContentView()
}
