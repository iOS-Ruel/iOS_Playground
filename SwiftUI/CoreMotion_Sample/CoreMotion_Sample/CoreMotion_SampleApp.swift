//
//  CoreMotion_SampleApp.swift
//  CoreMotion_Sample
//
//  Created by Chung Wussup on 7/3/24.
//

import SwiftUI

@main
struct CoreMotion_SampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                //            ContentView()
//                RotationView()
//                MagneticView()
                DeviceMotionView()
            }
        }
    }
}
