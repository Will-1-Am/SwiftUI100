//
//  ProjectOverview.swift
//  Moonshot
//
//  Created by William Spanfelner on 02/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ProjectOverview: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("example")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
                //                .clipped()
            }
            //MARK: ScrollView for scrolling views of arbitrary data that can be scrolled horizontally or vertically. ScrollView is created immediately as can be observed from the text printed in the example below.  Compare that to the List created in the next view which creates the view lazily, eg the lines are printed to corespond with the list view items displayed on the screen.
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    ForEach(0..<100) {
                        CustomText("Item \($0)")
                            .font(.title)
                    }
                }
                    //MARK: To force the scrollView to occupy all of the horizontal space while maintaining the centered appearance:
                .frame(maxWidth: .infinity)
            }
            
            // MARK: List views are created lazily
            List {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                    .font(.title)
                }
            }
            /*
             MARK: NavigationView allows views to be pushed onto a view stack. When a user taps on the Hello World text view, it will be made to present a different view with NavigationLink.
             */
            /*
             MARK: NavigationLink transforms the Text view into a button which, when tapped, presents the Detail View.  The NavigationBarTitle also transforms to a back button to take one back to the start.
             */
            NavigationView {
                VStack {
                    NavigationLink(destination: Text("Detail View")) {
                       Text("Hello World")
                    }
                }
            .navigationBarTitle("SwiftUI")
            }
            /*
             MARK: NavigationLink is quite magical when used with a list as is automatically adds disclosure indicators that guide the user to expect additional related information regarding the item they selected.
             */
            NavigationView {
                List(0..<100) { row in
                    NavigationLink(destination: Text("Detail \(row)")) {
                        Text("Row \(row)")
                    }
                }
            .navigationBarTitle("SwiftUI")
            }
            
            Button("Decode JSON") {
                let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                    "street": "555 Taylor Swift Avenue",
                    "city": "Nashville",
                    }
                }
                """
                
                // more code to come
                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                
                if let user = try? decoder.decode(User.self, from: data) {
                    print(user.address.street)
                }
            }
        }
    }
}

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating new CustomText")
        self.text = text
    }
}

struct ProjectOverview_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOverview()
    }
}
