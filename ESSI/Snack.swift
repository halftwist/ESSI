//
//  Snack.swift
//  ESSI
//
//  Created by John Kearon on 5/1/25.
//

import Foundation
import SwiftData

@Model
class snack {
    var name: String
    var onHand: Int
    var notes: String
    var comfortLevel: Int
    
//    With optional values i the initializer:
//      Default option will not add any initialized values when the class is added via code completion
//    i.e. paramters will appear grayed out
//    But hold down the Option key & the gray optional values become darker and if you prress return and accept code completion, you'll be given all paaramters
    
    init(name: String = "", onHand: Int = 0, notes: String = "", comfortLevel: Int = 1) {
        self.name = name
        self.onHand = onHand
        self.notes = notes
        self.comfortLevel = comfortLevel
    }
    
    
}
