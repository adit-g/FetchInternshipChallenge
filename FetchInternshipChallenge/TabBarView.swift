//
//  TabBarView.swift
//  FetchInternshipChallenge
//
//  Created by Adit G on 10/1/23.
//

import SwiftUI

struct TabBarView: View {
    
    // keeps track of which listId is being shown
    @Binding var currentTab: Int
    
    // the unique listIds in the data
    var listIds: [Int]
    
    // stores animation namespace to allow for matched animations between the different
    // TabBarItems
    @Namespace var namespace
    
    var body: some View {
        VStack {
            Text("List ID:")
                .padding(.top)
                .foregroundColor(.black)

            // make a TabBarItem for each listId
            HStack(spacing: 20) {
                ForEach(listIds, id: \.self) { key in
                    TabBarItem(
                        currentTab: $currentTab,
                        namespace: namespace.self,
                        tab: key
                    )
                }
            }
            .padding(.horizontal)
            .background(.white)
        }
        .frame(height: 50)
        .background(.white)
    }
}
