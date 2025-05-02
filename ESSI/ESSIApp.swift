//
//  ESSIApp.swift
//  ESSI
//
//  Created by John Kearon on 5/1/25.
//

import SwiftUI
import SwiftData

@main
struct ESSIApp: App {
    var body: some Scene {
        WindowGroup {
            SnackListView()
                .modelContainer(for: Snack.self)   // for:modelType The model type defining the schema used to create the model container.

        }
    }
    // will allow us to find where our simulator data is saved:  used by DB Browser app
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }

}
