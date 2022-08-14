//
//  PetObj.swift
//  PetTap
//
//  Created by Arin Haynes on 8/13/22.
//

import Foundation
import SwiftUI

class Pets {
    var animal: String
    var owned: Bool
    var price: Int
    var sounds: [String]
    
    init (animal: String) {
        self.animal = animal
        self.owned = false
        if(animal == "cat") {
            self.price = 100
            sounds = ["Meow1", "Meow2", "Meow3", "Meow4"]
        } else if (animal == "dog") {
            self.price = 100
            sounds = ["Woof1", "Woof2", "Woof3", "Woof4"]
        } else if (animal == "bird") {
            self.price = 100
            sounds = ["Chirp1", "Chirp2", "Chirp3", "Chirp4"]
        } else {
            self.price = 0
            sounds = []
        }
        
    }

}
