//
//  ContentView.swift
//  Moonshot - Project08 Challenge 3 - Make a bar button in ContentView that toggles between showing launch dates and showing crew names.
//
//  Created by William Spanfelner on 01/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//  (Astronaut and mission information has been copied from Wikipedia. Credit to  Wikipedia and its authors. The work is licensed under CC-BY-SA available from here)[https://creativecommons.org/licenses/by-sa/3.0]

import SwiftUI

let missions: [Mission] = Bundle.main.decode("missions.json")

struct ContentView: View {
    /*
     MARK: This view is responsible for displaying a mission patch image, a mission number and the launch date in a list view with each entry opening a subview displaying more detailed information.  To support those goals the supporting information is decoded from two json files - astronauts.json & missions.json - into their respective arrays.
     */
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    // Challenge 3 Create a dictionary of crew members by mission
    var crew: [String: String] {
        var membersByMission = [String: String]()
        var members = ""
        
        for mission in missions {
            
            for member in mission.crew {
                members += member.name.capitalized + " "
            }
            membersByMission[mission.displayName] = members
            members = ""
        }
        return membersByMission
    }
    // Challenge 3 Create state var to show crew members or the Launch date
    @State private var showCrew = false
    
    /*
     MARK: Below the main list view is described with a link to the detail MissionView descibing the relevant detail for the mission selected.
     */
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        
                        //Challenge 3 - Create a Text view to display the results dependent upon the toggle created below
                        Text(self.showCrew ? self.crew[mission.displayName] ?? "" : mission.formattedLaunchDate)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Toggle("Show crew?", isOn: $showCrew).font(.caption))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
