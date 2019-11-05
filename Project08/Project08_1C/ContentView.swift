//
//  ContentView.swift
//  Moonshot - Project08 Challenge 1 - Add the launch date to MissionView, below the mission badge.
//
//  Created by William Spanfelner on 01/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//  (Astronaut and mission information has been copied from Wikipedia. Credit to  Wikipedia and its authors. The work is licensed under CC-BY-SA available from here)[https://creativecommons.org/licenses/by-sa/3.0]

import SwiftUI

struct ContentView: View {
    /*
     MARK: This view is responsible for displaying a mission patch image, a mission number and the launch date in a list view with each entry opening a subview displaying more detailed information.  To support those goals the supporting information is decoded from two json files - astronauts.json & missions.json - into their respective arrays.
     */
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    
    /*
     MARK: Below the main list view is described with a link to the detail MissionView descibing the relevant detail for the mission selected.
     */
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
//                NavigationLink(destination: Text("Detail view")) {
                    Image(mission.image)
                        .resizable()
                        //                        .aspectRatio(contentMode: .fit)
                        //MARK: .scaledToFit() is equivalent to the line above.
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
