//
//  ContentView.swift
//  BackgroundTest
//
//  Created by Daniel Burkard on 19.05.20.
//  Copyright © 2020 Daniel Burkard. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var dates: [String] = []
    var body: some View {
        VStack {
            Group {
                if dates.isEmpty {
                    Text("No background runs")
                } else {
                    List(dates, id: \.self) {
                        Text($0)
                    }
                }
            }.onAppear {
                self.dates = BackgroundRun.getRuns()
            }
            Button(action: {
                self.dates = BackgroundRun.getRuns()
            }) {
                Text("Refresh")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
