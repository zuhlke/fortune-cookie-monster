//
//  MotionService.swift
//  Fortune Cookie Monster
//
//  Created by Jonathan Rothwell on 04/06/2018.
//  Copyright © 2018 Zuhlke UK. All rights reserved.
//

import Foundation
import CoreMotion

struct MotionService {
    let manager = CMMotionManager()
    let queue = OperationQueue()
    
    private let recorder = MotionRecorder()
    
    private var aggregateFigure: Double = 0
    
    init() {
        guard manager.isDeviceMotionAvailable else {
            fatalError("No device motion available! 😱")
        }
        manager.showsDeviceMovementDisplay = true
        manager.startDeviceMotionUpdates()
    }
    
    func beginRecordingMotion() {
        recorder.reset()
        manager.startDeviceMotionUpdates(to: queue) { motion, error in
            guard error == nil,
                let motion = motion else {
                    fatalError("DISASTER!")
            }
//            self.aggregateFigure += motion.attitude.pitch * motion.attitude.yaw * motion.attitude.roll
            self.recorder.add(motion.attitude.pitch + motion.attitude.yaw + motion.attitude.roll)
        }
    }
    
    func getCurrentVector() -> Double? {
        return manager.deviceMotion.map { motionData in
            NSLog("x: %.2f, y: %.2f, z: %.2f", motionData.attitude.pitch, motionData.attitude.yaw, motionData.attitude.roll)
            return motionData.attitude.pitch * motionData.attitude.yaw * motionData.attitude.roll
        }
    }
    
    func stopRecordingMotion() -> Double {
        manager.stopDeviceMotionUpdates()
        return recorder.aggregateNumber
    }
}


private class MotionRecorder {
    fileprivate(set) var aggregateNumber: Double
    init() {
        aggregateNumber = 0
    }
    
    func reset() {
        aggregateNumber = 0
    }
    
    func add(_ number: Double) {
        aggregateNumber += number
    }
    
    func getNumber() -> Double {
        return aggregateNumber
    }
}
