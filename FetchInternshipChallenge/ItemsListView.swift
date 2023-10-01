//
//  ContentView.swift
//  FetchInternshipChallenge
//
//  Created by Adit G on 9/30/23.
//

import SwiftUI

struct ItemsListView: View {
    var items = ["item1", "item2", "item3", "item4"]
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .font(.title2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Items")
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView()
    }
}
