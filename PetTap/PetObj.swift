//
//  PetObj.swift
//  PetTap
//
//  Created by Arin Haynes on 8/13/22.
//

import Foundation
import SwiftUI

enum PetType: Codable, CaseIterable {
    case none
    case cat
    case dog
    case bird
    case bunny
    case fish
    
    static var displaybleTypes: [PetType] {
        return [.cat, .dog, .bird, .bunny, .fish]
    }
    
    var name: String {
        switch (self) {
        case .none:
            return ""
        case .cat:
            return "cat"
        case .dog:
            return "dog"
        case .bird:
            return "bird"
        case .bunny:
            return "bunny"
        case .fish:
            return "fish"
        }
    }
    
    var price: Int {
        switch (self) {
        case .none:
            return 0
        case .cat:
            return 1000
        case .dog:
            return 1000
        case .bird:
            return 200
        case .bunny:
            return 500
        case .fish:
            return 50
        }
    }
    
    var sounds: [String] {
        switch (self) {
        case .none:
            return []
        case .cat:
            return ["Meow1", "Meow2", "Meow3", "Meow4"]
        case .dog:
            return ["Woof1", "Woof2", "Woof3", "Woof4"]
        case .bird:
            return ["Chirp1", "Chirp2", "Chirp3", "Chirp4"]
        case .bunny:
            return ["Boing1", "Boing2", "Boing3", "Boing4"]
        case .fish:
            return ["Bubbles1", "Bubbles2", "Bubbles3", "Bubbles4"]
        }
    }
    
    var imageNameNormal: String {
        switch (self) {
        case .none:
            return ""
        case .cat:
            return "Cat1"
        case .dog:
            return "Dog1"
        case .bird:
            return "Bird1"
        case .bunny:
            return "Bunny1"
        case .fish:
            return "Fish1"
        }
    }
    
    var imageNameExcited: String {
        switch (self) {
        case .none:
            return ""
        case .cat:
            return "Cat2"
        case .dog:
            return "Dog2"
        case .bird:
            return "Bird2"
        case .bunny:
            return "Bunny2"
        case .fish:
            return "Fish2"
        }
    }
}

class Pets: Codable {
    var animalType: PetType
    var owned: Bool
    
    init (animal: PetType) {
        self.animalType = animal
        self.owned = false
    }
}
