//
//  DeviceMotionView.swift
//  CoreMotion_Sample
//
//  Created by Chung Wussup on 7/3/24.
//

import SwiftUI
import CoreMotion

struct DeviceMotionView: View {
    let motionManager = CMMotionManager()
    
    //기계적으로 발생하는 신호이기 때문에 Queue가 필요함
    let queue = OperationQueue()
    
    @State private var pitch: Double = 0.0
    @State private var yaw: Double = 0.0
    @State private var roll: Double = 0.0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        VStack {
            Text("Pitch: \(pitch)")
            Text("Yaw: \(yaw)")
            Text("Roll: \(roll)")
        }
        .navigationTitle("DeviceMotionView")
        .onAppear {
            motionManager.startDeviceMotionUpdates(to: queue) { (data: CMDeviceMotion? ,error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                
                let trackMotion: CMAttitude = data.attitude
                motionManager.deviceMotionUpdateInterval = 0.5
                DispatchQueue.main.async {
                    pitch = trackMotion.pitch
                    yaw = trackMotion.yaw
                    roll = trackMotion.yaw
                }
                
            }
        }
    }
        
}

#Preview {
    DeviceMotionView()
}
