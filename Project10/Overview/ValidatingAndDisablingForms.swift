//
//  ValidatingAndDisablingForms.swift
//  CupcakeCorner
//
//  Created by William Spanfelner on 11/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ValidatingAndDisablingForms: View {
    @State var username = ""
    @State var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
//        username.isEmpty || email.isEmpty
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account"){
                    print("creating account…")
                }
            }
            .disabled(disableForm)
        }
    }
}

struct ValidatingAndDisablingForms_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingAndDisablingForms()
            .environment(\.colorScheme, .dark)
    }
}
