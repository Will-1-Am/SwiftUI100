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
    // Challenge 2 - Create a property to store missions flown and read in mission data from json
    var missionsFlown: [Mission]
//    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    //Challenge 2 - Initializer for the primary purpose of setting up and matching data where astronauts flew a particular mission
    init(astronaut: Astronaut, missionsFlown: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        
        for mission in missions {
            if mission.crew.contains(where: { $0.name == astronaut.id } ) {
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
                    //Challenge 2 - display the flight info under astronaut image
                    Text("Missions Flown:").font(.caption)
                    HStack {
                        ForEach(self.missionsFlown) { mission in
                            Text("Apollo \(mission.id)")
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
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missionsFlown: [Mission(id: 2, launchDate: nil, crew: [Mission.CrewRole(name: "Buzz Lightyear", role: "Commander")], description: "The greatest mission")])
    }
}
