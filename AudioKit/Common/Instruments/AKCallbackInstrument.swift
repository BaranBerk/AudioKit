//
//  AKCallbackInstrument.swift
//  AudioKit
//
//  Created by Aurelius Prochazka, revision history on Github.
//  Copyright © 2016 AudioKit. All rights reserved.
//

/// Function type for MIDI callbacks
public typealias AKMIDICallback = (AKMIDIStatus, MIDINoteNumber, MIDIVelocity) -> Void

/// MIDI Instrument that triggers functions on MIDI note on/off commands
public class AKCallbackInstrument: AKMIDIInstrument {

    // MARK: Properties

    /// All callbacks that will get triggered by MIDI events
    public var callbacks = [AKMIDICallback]()

    /// Initialize the callback instrument
    ///
    /// - parameter callback: Initial callback
    ///
    public init(callback: AKMIDICallback) {
        // Dummy Instrument
        super.init(instrument: AKPolyphonicInstrument(voice: AKVoice(), voiceCount: 0))
        let midi = AKMIDI()
        self.enableMIDI(midi.client, name: "callback midi in")
        callbacks.append(callback)
    }

    private func triggerCallbacks(status: AKMIDIStatus, noteNumber: MIDINoteNumber, velocity: MIDIVelocity) {
        for callback in callbacks {
            callback(status, noteNumber, velocity)
        }
    }

    /// Will trigger in response to any noteOn Message
    ///
    /// - Parameters:
    ///   - noteNumber: MIDI Note Number being started
    ///   - velocity:   MIDI Velocity (0-127)
    ///   - channel:    MIDI Channel
    ///
    override public func start(noteNumber noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: Int) {
        triggerCallbacks(.NoteOn, noteNumber: noteNumber, velocity: velocity)
    }

    /// Will trigger in response to any noteOff Message
    ///
    /// - Parameters:
    ///   - noteNumber: MIDI Note Number being stopped
    ///   - velocity:   MIDI Velocity (0-127)
    ///   - channel:    MIDI Channel
    ///
    override public func stop(noteNumber noteNumber: MIDINoteNumber, channel: Int) {
        triggerCallbacks(.NoteOff, noteNumber: noteNumber, velocity: 0)
    }
}