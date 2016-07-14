//
//  AKDistortionPresets.swift
//  AudioKit 
//
//  Created by Nicholas Arner on 7/2/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import Foundation

/// Preset for the AKDistortion
public extension AKDistortion {
    
    public func presetInfiniteDistortionWall() {
        delay = 475.776
        decay = 40.579
        delayMix = 0.820
        linearTerm = 0.760
        squaredTerm = 0.729
        cubicTerm = 1.000
        polynomialMix = 0.500
        softClipGain = -8.441
        finalMix = 0.798
    }

}