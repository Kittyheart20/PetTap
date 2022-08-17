//
//  PetObj.swift
//  PetTap
//
//  Created by Arin Haynes on 8/13/22.
//

import Foundation
import SwiftUI

class Pets: Codable {
    var animal: String
    var owned: Bool
    var price: Int
    var sounds: [String]
    
    init (animal: String) {
        self.animal = animal
        self.owned = false
        if(animal == "cat") {
            self.price = 1000
            sounds = ["Meow1", "Meow2", "Meow3", "Meow4"]
        } else if (animal == "dog") {
            self.price = 1000
            sounds = ["Woof1", "Woof2", "Woof3", "Woof4"]
        } else if (animal == "bird") {
            self.price = 200
            sounds = ["Chirp1", "Chirp2", "Chirp3", "Chirp4"]
        } else if (animal == "bunny") {
            self.price = 500
            sounds = ["Boing1", "Boing2", "Boing3", "Boing4"]
        } else if (animal == "fish") {
            self.price = 50
            sounds = ["Bubbles1", "Bubbles2", "Bubbles3", "Bubbles4"]
        } else {
            self.price = 0
            sounds = []
        }
        
    }

}
