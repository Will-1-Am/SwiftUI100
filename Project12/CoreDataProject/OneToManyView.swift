//
//  OneToManyView.swift
//  CoreDataProject
//
//  Created by William Spanfelner on 20/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct OneToManyView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                let candy5 = Candy(context: self.moc)
                candy5.name = "Twizzlers"
                candy5.origin = Country(context: self.moc)
                candy5.origin?.shortName = "USA"
                candy5.origin?.fullName = "United States of America"
                
                try? self.moc.save()
            }
        }
    }
}

struct OneToManyView_Previews: PreviewProvider {
    static var previews: some View {
        OneToManyView()
    }
}
