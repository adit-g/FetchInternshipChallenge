//
//  ItemsModel.swift
//  FetchInternshipChallenge
//
//  Created by Adit G on 9/30/23.
//

import Foundation

class ItemsModel: ObservableObject {
    private struct Items: Codable {
        var items: [Item]
    }

    private struct Item: Codable {
        var id: Int
        var listId: Int
        var name: String?
    }
    
    var urlString = "https://fetch-hiring.s3.amazonaws.com/hiring.json"
    
    func getData() async {
        guard let url = URL(string: urlString) else {
            print("ERROR: could not get URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Items.self, from: data) else {
                print("ERROR: could not decode json data")
                return
            }
            print("The call worked! \(returned.items[2].name ?? "null")")
        } catch {
            print("ERROR: could not get data from \(urlString)")
        }
    }
}
