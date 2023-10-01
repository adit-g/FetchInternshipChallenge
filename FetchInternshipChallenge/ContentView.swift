//
//  ContentView.swift
//  FetchInternshipChallenge
//
//  Created by Adit G on 9/30/23.
//

import SwiftUI

struct ContentView: View {
    // keeps track of which listId is being shown
    @State private var currentTab = 1
    
    // stores all filtered and sorted items indexed by their listId
    // e.g. {2 : [Item(id: 234, listId: 2, name: "Item 234")]}
    @State private var items = [Int: [Item]]()
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView (selection: $currentTab) {
                ForEach(items.keys.sorted(), id: \.self) { key in
                    ItemsListView(items: items[key] ?? []).tag(key)
                        .offset(y: 64)
                }
            }
            .ignoresSafeArea(.all)
            
            TabBarView(currentTab: self.$currentTab, listIds: items.keys.sorted())
        }
        .task {
            await loadData()
        }
    }
    
    // fetches data from endpoint
    private func loadData() async {
        let urlString = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
        guard let url = URL(string: urlString) else {
            print("ERROR: bad url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode([Item].self, from: data) else {
                print("ERROR: could not decode json data")
                return
            }
            
            let filtered = filterData(data: returned)
            items = sortData(data: filtered)
        } catch {
            print("ERROR: could not get data from \(urlString)")
        }
    }
    
    // removes all names that are null or blank from data
    private func filterData(data: [Item]) -> [Item] {
        data.filter({ item in item.name != nil && item.name != "" })
    }
    
    // sorts data and indexes each item by its listId
    private func sortData(data: [Item]) -> [Int: [Item]] {
        let sortedData = data.sorted(by: {item1, item2 in item1.name! < item2.name!})
        var sortedByListID = [Int: [Item]]()
        for item in sortedData {
            if sortedByListID[item.listId] == nil {
                sortedByListID[item.listId] = []
            } else {
                sortedByListID[item.listId]!.append(item)
            }
        }
        return sortedByListID
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
