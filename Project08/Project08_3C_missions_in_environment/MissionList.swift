//
//  MissionList.swift
//  Moonshot
//
//  Created by William Spanfelner on 01/05/2020.
//  Copyright © 2020 William Spanfelner. All rights reserved.
//

import Foundation

class MissionList: ObservableObject {
    @Published var missionList: [Mission] = Bundle.main.decode("missions.json")
}
