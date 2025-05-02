//
//  Snack.swift
//  ESSI
//
//  Created by John Kearon on 5/1/25.
//

import Foundation
import SwiftData

// A singleton actor whose executor is equivalent to the main dispatch queue. Enables tasks that typically do not run on the main thread (loading mock data) to run on the main thread
//@MainActor   // A singleton actor whose executor is equivalent to the main dispatch queue. Enables tasks that typically do not run on the main thread (loading mock data) to run on the main thread
@Model
class Snack {
    var name: String
    var onHand: Int
    var notes: String
    var comfortLevel: Int
    
//    With optional values in the initializer:
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


extension Snack {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Snack.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        // add mock data
//        container.mainContext.insert(Snack(name: "Cheddar Goldfish", onHand: 3, notes: "Best eaten by the handful while doomscrolling.", comfortLevel: 1))
//        container.mainContext.insert(Snack(name: "Spicy Takis", onHand: 1, notes: "Left lips numb last time. No regrets.", comfortLevel: 2))
//        container.mainContext.insert(Snack(name: "Frozen Thin Mints", onHand: 3, notes: "A classy cold snack. Seasonal, like depression.", comfortLevel: 1))
//        container.mainContext.insert(Snack(name: "Trader Joe’s Scandinavian Swimmers", onHand: 2, notes: "Pretends to be healthy. Not fooling anyone.", comfortLevel: 3))
//        container.mainContext.insert(Snack(name: "Mom's Cookies", onHand: 1, notes: "Nothing better. Like a warm blanket", comfortLevel: 5))

//   @MainActor A singleton actor whose executor is equivalent to the main dispatch queue. Enables tasks that typically do not run on the main thread (loading mock data) to run on the main thread
        Task {@MainActor in
            container.mainContext.insert(Snack(
                name: "Cheddar Goldfish",
                onHand: 3,
                notes: "Best eaten by the handful while doomscrolling.",
                comfortLevel: 1
            ))
            container.mainContext.insert(Snack(
                name: "Spicy Takis",
                onHand: 1,
                notes: "Left lips numb last time. No regrets.",
                comfortLevel: 2
            ))
            container.mainContext.insert(Snack(
                name: "Frozen Thin Mints",
                onHand: 3,
                notes: "A classy cold snack. Seasonal, like depression.",
                comfortLevel: 1
            ))
            container.mainContext.insert(Snack(
                name: "Trader Joe’s Scandinavian Swimmers",
                onHand: 2,
                notes: "Pretends to be healthy. Not fooling anyone.",
                comfortLevel: 3
            ))
            container.mainContext.insert(Snack(
                name: "Mom's Cookies",
                onHand: 1,
                notes: "Nothing better. Like a warm blanket",
                comfortLevel: 5
            ))

        }
        
        
        return container
    }

    func purgeData() {
        let path = URL.documentsDirectory.appending(component: "Snack")
        let data = try? JSONEncoder().encode("")
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: Could not purge data: \(error.localizedDescription)")
        }
    }
}
