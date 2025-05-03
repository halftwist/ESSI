//
//  SnackDetailView.swift
//  ESSI
//
//  Created by John Kearon on 5/3/25.
//

import SwiftUI
import SwiftData

struct SnackDetailView: View {
    
    enum ComfortLevel: Int, CaseIterable {
        case doesTheJob = 1, solid, cravingSatisfyer, emergencyComfort
    }
    
    @State var snack: Snack // single Swift Data object passed from SnackListView
    @State private var name = ""
    @State private var onHand = 0
    @State private var notes = ""
    @State private var selectedComfortLevel = 0

    // \.dismiss  An action that dismisses the current presentation.
//   @Environment: A property wrapper that reads a value from a view’s environment.
    @Environment(\.dismiss) private var dismiss
//  modelContext The SwiftData model context that will be used for queries and other model operations within this environment.
    @Environment(\.modelContext) private var modelContext // holds temporary data in memory until saved

    
    var body: some View {
//        List {
//            TextField("snack name", text: $name)
//                .font(.largeTitle)
//                .textFieldStyle(.roundedBorder)
//                .padding(.vertical)
//                .listRowSeparator(.hidden)
// 
//            TextField("Qty:", text: \($onHand))
//                .font(.largeTitle)
//                .textFieldStyle(.roundedBorder)
//                .padding(.vertical)
//                .listRowSeparator(.hidden)
//
//
//        }
        VStack(alignment:.leading) {
            TextField("snack name", text: $name)
                .font(.largeTitle)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Text("Qty:")
                Spacer()
                Text("\(onHand)")
                Stepper("", value: $onHand, in: 0...Int.max)
                    .labelsHidden()
            }
            .padding(.bottom)
            
            HStack {
                Text("Comfort Level:")
                    .bold()
                Picker("", selection: $selectedComfortLevel) {
                    ForEach(ComfortLevel.allCases, id: \.self) { comfortlevel in
                        Text("\(comfortlevel)")
                            .tag(comfortlevel.rawValue)
                    }

//                    ForEach(ComfortLevel.allCases, id: \.self ) { level in
//                        Text(String(level))
//                    }
                }
                
            }
            
            Text("Notes:").bold()
            TextField("notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
            
            Spacer()
        }
        .padding(.horizontal)
        .font(.title2)
        .navigationBarBackButtonHidden(true)
        .toolbar {  // from SnackListView
            ToolbarItem(placement: .topBarLeading) {
               Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
               Button("Save") {
                   snack.name = name
                   snack.onHand = onHand
                   snack.notes = notes
                   snack.comfortLevel = selectedComfortLevel
                   modelContext.insert(snack) // will add new or update existing
                   guard let _ = try? modelContext.save() else { // only needed for simulator forces save so you can browse with DB Browser
                       print("😡 ERROR: modelContext.save didn't work in SnackDetaiView.save")
                       return
                   }
                   dismiss()
                }
            }
 
        }
        .onAppear {
            name = snack.name
            onHand = snack.onHand
            notes = snack.notes
            selectedComfortLevel = snack.comfortLevel
        }
    }
}

#Preview {
    NavigationStack {
        SnackDetailView(snack: Snack(
            name: "Lil Swifties",
            onHand: 3,
            notes: "Homemade cookies baked by Prof. G He will bring these for Lunar New Year",
            comfortLevel: 5
        ))
    }
//        .modelContainer(for: Snack.self, inMemory: true)
}
