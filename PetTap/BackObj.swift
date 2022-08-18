//
//  BackObj.swift
//  PetTap
//
//  Created by Arin Haynes on 8/14/22.
//

import Foundation
import SwiftUI

class Back {
    var back: String
    var owned: Bool
    var price = 100
    
    init (back: String) {
        self.back = back
        self.owned = false
    }

}
