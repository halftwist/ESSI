//
//  SnackListView.swift
//  ESSI
//
//  Created by John Kearon on 5/1/25.
//

import SwiftUI
import SwiftData


struct SnackListView: View {
    
    @Query var snacks:[Snack] // Fetches all instances of the attached model type.
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) var modelContext  // The SwiftData model context that will be used for queries and other model operations within this environment. This is for holding temporary data before saving

    var body: some View {
        NavigationStack {
            List {
                ForEach(snacks) { snack in
                    
                    NavigationLink {  // always choose destination and label
                        SnackDetailView(snack: snack)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(snack.name)
                                .font(.title)
                                .lineLimit(1)

                            HStack {
                                Text("Qty:\(snack.onHand)")
                                Text("\(snack.notes)")
                                    .italic()
                                    .lineLimit(1)
                                    .foregroundStyle(.secondary)
                            }
                            .font(.body)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(snack)
                            guard let _ = try? modelContext.save() else {
                                print("😡 Swipe to delete didn't work")
                                return
                            }
                        }
                     }
                }
                
            }
            .navigationTitle("Snacks on Hand:")  // must be inside the NavigationStack {}
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .sheet(isPresented: $sheetIsPresented) { // select .sheet isPresented Content option, then enter isPresented, followed by tab followed by return to remove content variable
                NavigationStack {  // so that the detail view will have a toolbar
                    SnackDetailView(snack: Snack())
                } // will provide default values
            }
        }
    }
}

#Preview {
    SnackListView()
        .modelContainer(Snack.preview)
}
