//
//  ContentView.swift
//  FetchInternshipChallenge
//
//  Created by Adit G on 9/30/23.
//

import SwiftUI

struct ItemsListView: View {
    var items: [Item]
    
    // takes an array of items and just displays them in a list
    var body: some View {
        List(items, id: \.id) { item in
            Text(item.name ?? "")
                .foregroundColor(.black)
                .font(.title2)
                .listRowBackground(Color.white)
        }
        .listStyle(.plain)
        .background(.white)
        .scrollContentBackground(.hidden)
        .ignoresSafeArea()
        
    }
}


