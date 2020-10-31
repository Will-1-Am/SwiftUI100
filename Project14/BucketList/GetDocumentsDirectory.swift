//
//  GetDocumentsDirectory.swift
//  BucketList
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation

//MARK: The getDocumentsDirectory method below get returns the users document directory where there is only the physical device limit in terms of the amount of data that can be stored there.  This contrasts UserDefaults storage that is meant for settings type data.
func getDocumentsDirectory() -> URL {
    //find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    //just send back the first one, which ought to be the only one
    return paths[0]
}
