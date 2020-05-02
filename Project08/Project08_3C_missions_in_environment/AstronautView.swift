//
//  AstronautView.swift
//  Moonshot
//
//  Created by William Spanfelner on 03/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missionsFlown: [Mission]
    
    init(missions: MissionList, astronaut: Astronaut, missionsFlown: [Mission]) {
        self.astronaut = astronaut

        var matches = [Mission]()

        for mission in missions.missionList {
            if mission.crew.contains(where: { $0.name == astronaut.id }) {
                matches.append(mission)
            }
        }
        self.missionsFlown = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Group {
                        Text("Missions Flown:")
                        HStack {
                            ForEach(self.missionsFlown) { mission in
                                Text(mission.displayName)
                            }
                        }
                    }.font(.caption)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions = MissionList()
    
    static var previews: some View {
        AstronautView(missions: missions, astronaut: astronauts[7], missionsFlown: [Mission(id: 2, launchDate: nil, crew: [Mission.CrewRole(name: "Buzz Lightyear", role: "Commander")], description: "None")])
    }
}
