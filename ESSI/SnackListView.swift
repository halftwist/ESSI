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
    @Environment(\.modelContext) var modelContext  // The SwiftData model context that will be used for queries and other model operations within this environment. This is for holding temporary data before saving

    var body: some View {
        NavigationStack {
            List {
                ForEach(snacks) { snack in
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
                
            }
            .navigationTitle("Snacks on Hand:")  // must be inside the NavigationStack {}
            .listStyle(.plain)
        }
    }
}

#Preview {
    SnackListView()
        .modelContainer(Snack.preview)
}
