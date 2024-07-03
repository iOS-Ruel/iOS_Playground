//
//  RotationView.swift
//  CoreMotion_Sample
//
//  Created by Chung Wussup on 7/3/24.
//

import SwiftUI
import CoreMotion

struct RotationView: View {
    let motionManager = CMMotionManager()
    
    //기계적으로 발생하는 신호이기 때문에 Queue가 필요함
    let queue = OperationQueue()
    
    @State private var x: Double = 0.0
    @State private var y: Double = 0.0
    @State private var z: Double = 0.0
    
    
    var body: some View {
        VStack {
            Text("x: \(x)")
            Text("y: \(y)")
            Text("z: \(z)")
        }
        .navigationTitle("Rotation")
        .padding()
        .onAppear {
            motionManager.startGyroUpdates(to: queue) { (data: CMGyroData?, error: Error?) in
                guard let data = data else {
                    print("Error: \(error!)")
                    return
                }
                
                let trackMotion: CMRotationRate = data.rotationRate
                motionManager.gyroUpdateInterval = 0.5
                
                DispatchQueue.main.async {
                    x = trackMotion.x
                    y = trackMotion.y
                    z = trackMotion.z
                }
                
            }
        }
    }
}

#Preview {
    RotationView()
}
