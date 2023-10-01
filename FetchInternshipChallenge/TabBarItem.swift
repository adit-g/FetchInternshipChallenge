//
//  TabBarItem.swift
//  FetchInternshipChallenge
//
//  Created by Adit G on 10/1/23.
//

import SwiftUI

struct TabBarItem: View {
    
    // keeps track of which listId is being shown
    @Binding var currentTab: Int
    
    // stores animation namespace to allow for matched animations between the different
    // TabBarItems
    let namespace: Namespace.ID
    
    // the listId that this particular TabBarItem represents
    var tab: Int
    
    var body: some View {
        Button {
            currentTab = tab
        } label: {
            VStack {
                Spacer()
                
                Text(tab.description)
                    .foregroundColor(.black)
                
                // the line animation thing
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(
                            id: "underline",
                            in: namespace,
                            properties: .frame
                        )
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
            
        }
        .buttonStyle(.plain)
        .background(.white)
    }
}

