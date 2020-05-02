//
//  ContentView.swift
//  Moonshot
//
//  Created by William Spanfelner on 01/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//  (Astronaut and mission information has been copied from Wikipedia. Credit to  Wikipedia and its authors. The work is licensed under CC-BY-SA available from here)[https://creativecommons.org/licenses/by-sa/3.0]
//


import SwiftUI

//let missions: [Mission] = Bundle.main.decode("missions.json")

struct ContentView: View {
    @ObservedObject var missions = MissionList()
    @State private var showDate = true

    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        NavigationView {
            List(missions.missionList) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)

                        HStack {
                            if self.showDate {
                                Text(mission.formattedLaunchDate)
                            } else {
                                /*
                                 The ForEach loop here can be indexed by \.self which will require Hashable conformance, but a more logical way of indexing the loop will be by role - at least in Apollo missions there was no role duplication.
                                 */
                                ForEach(mission.crew, id: \.role) { member in
                                    HStack {
                                        Text(member.name.capitalized)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Moonshot")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showDate.toggle()
                    }) {
                        self.showDate ? Text("Crew") : Text("Launch Date")
                    }
                )
            }
        }
    .environmentObject(missions)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
