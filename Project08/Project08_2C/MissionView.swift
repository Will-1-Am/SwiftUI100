//
//  MissionView.swift
//  Moonshot
//
//  Created by William Spanfelner on 03/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
/*
 MARK: The mission view will display the mission patch image, a description of the mission, and buttons with the astronaut's images that will open another detail page.  The mission and astronaut information are passed through from ContentView and MissionView is initialized with this information.
 */

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                    .resizable()
                    .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.description)
                    .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missionsFlown: [self.mission])) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: crewMember.role.lowercased().contains("commander") ? 91 : 83,
                                           height: crewMember.role.lowercased().contains("commander") ? 66 : 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: crewMember.role.lowercased().contains("commander") ? 5 : 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal)
                        }
                    .buttonStyle(PlainButtonStyle())
                    }
                    
                    
                    /*
                     MARK: Spacer(minLength: 25) a spacer would normally take up all available remaining space, but that has no meaning inside a scroll view.  Additionally, if the design orientation ever changes from VStack to HStack the Spacer will automatically change orientation.
                     */
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
