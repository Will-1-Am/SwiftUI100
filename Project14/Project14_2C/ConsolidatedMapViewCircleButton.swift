//
//  ConsolidatedMapViewCircleButton.swift
//  BucketList 2C Project 14 - Challenge 2 - Having a complex if condition in the middle of ContentView isn’t easy to read – can you rewrite it so that the MapView, Circle, and Button are part of their own view? This might take more work than you think!
//
//  Created by William Spanfelner on 05/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import MapKit


struct ConsolidatedMapViewCircleButton: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            MapViewI(centerCoordinate: $centerCoordinate, annotations: locations, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
                .edgesIgnoringSafeArea(.all)
            
            /* */
            //Moving the Circle view from ContentView is straight forward as all of the modifiers are defined within the view
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        /* */
                        //create a new pin location
                        //MARK: Whenever the "plus" button is tapped the centerCoordinate will be added as an element of the array
                        //                        let newLocation = MKPointAnnotation()
                        //MARK: With the addition of the new CodableMKPointAnnotation class, a new instance is required
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        /* */
                        //hard code a title until a more flexible approach is adopted - "Pin title" might be better here
                        newLocation.title = "Example location"
                        
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .onAppear(perform: loadData)
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message:
                Text(selectedPlace?.subtitle ?? "Missing place information"),
                  primaryButton: .default(Text("OK")), secondaryButton:
                .default(Text("Edit")) {
                    //edit this place
                    self.showingEditScreen = true
                }
            )
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    }
    
    /* */
    //MARK: The following methods permit the application to save any number of data in any number of files.  This provides additional flexibility over UserDefaults like loading and saving as and when required rather than when the application launches.
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    /* */
    //MARK: Learn the url for the users document directory so their annotations can be store there.
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ConsolidatedMapViewCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        ConsolidatedMapViewCircleButton()
    }
}
