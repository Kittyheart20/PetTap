//
//  File.swift
//  PetTap
//
//  Created by Arin Haynes on 8/13/22.
//

import Foundation
import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    var bmPlayer: AVAudioPlayer?
    
    func startBM () {
        guard let url = Bundle.main.url(forResource: "BackgroundMusic", withExtension: ".mp3") else {return}
        do {
            bmPlayer = try AVAudioPlayer(contentsOf: url)
            bmPlayer?.prepareToPlay()
            bmPlayer?.numberOfLoops = -1
            bmPlayer?.play()
        } catch let error {
            print ("Error playing sound. \(error.localizedDescription)")
        }
    }
    
    func sound (soundType: String) {
        guard let url = Bundle.main.url(forResource: soundType, withExtension: ".mp3") else {return}
        
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch let error {
                print ("Error playing sound. \(error.localizedDescription)")
            }
    }
    
    func resumeBM () {
        bmPlayer?.prepareToPlay()
        bmPlayer?.numberOfLoops = -1
        bmPlayer?.play()
    }
    
    func stopSound () {
        bmPlayer?.pause()
    }
    
}
 
