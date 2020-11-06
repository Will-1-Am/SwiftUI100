//
//  ContentView.swift
//  BucketList - Project 14 - Challenge 1 - Our + button is rather hard to tap. Try moving all its modifiers to the image inside the button – what difference does it make, and can you think why?
//
//  Created by William Spanfelner on 30/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    /* */
    //MARK: An array for storing the users selected locations is req'd
//    @State private var locations = [MKPointAnnotation]()
    //MARK: The above state property is updated as follows for the purpose of saving user annotations locally
    @State private var locations = [CodableMKPointAnnotation]()
    
    /* */
    //MARK: Properties for the bindings in MapViewI
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    /* */
    //MARK: State for editing placemark details
    @State private var showingEditScreen = false
    
    /* */
    //MARK: Is the device unlocked?
    @State private var isUnlocked = false
    
    var body: some View {
        ZStack{
            if isUnlocked {
                
                MapViewI(centerCoordinate: $centerCoordinate, annotations: locations, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails)
//                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            //create a new pin location
                            //MARK: Whenever the "plus" button is tapped the centerCoordinate will be added as an element of the array
                            //         let newLocation = MKPointAnnotation()
                            //MARK: With the addition of the new CodableMKPointAnnotation class, a new instance is required
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.coordinate = self.centerCoordinate
                            //hard code a title until a more flexible approach is adopted
                            newLocation.title = "Example location"
                            
                            self.locations.append(newLocation)
                            self.selectedPlace = newLocation
                            self.showingEditScreen = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                            /*
                             Challenge 1 - Our + button is rather hard to tap. Try moving all its modifiers to the image inside the button – what difference does it make, and can you think why?
                             
                             Removing the image modifiers pushes the plus symbol to the trailing and bottom edge of the display (commenting out the .edgesIgnoringSafeArea(.all) MapViewI modifier will show the extents of that view), removes coloring, reduces the symbol size, removes the shape surrounding the symbol.
                             
                             Moving the modifiers from immediately outside the Button view curly brackets to the Image view makes no difference since this child view of the modifiers will request exactlty the same space as will the entire Button view. See the ButtonView.swift file in the main project for illustration.
                         
                             Changing the Image from "plus" to "plus.circle.fill" improves the ability to tap the "button" and suggests that the plus sign has a tapable area literaly defined by its visual boundary.
                             
                             Download SF Symbols https://developer.apple.com/design/resources/ for a comprehensive list of the names of each symbol.
                             */
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
            } else {
                // add button here
                Button("Unlock Places") {
                    self.authenticate()
                }
            .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
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
    /*
     MARK: authenticate will handle all of the biometrics and will:
     1. create an LAContext for performing authentication;
     2. determine whether the device is capable of biometrics;
     3. start the request, if possible, and run a closure on completion;
     4. push work back to the main thread, when everything finishes;
     5. if all successful, set isUnlocked to true

     */
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //MARK: The following reason is for TouchID as it must be provided in code.
            let reason = "Please authenticate yourself to unlock your places"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        
                    } else {
                        // error
                    }
                }
            }
        } else {
            //no biometrics
        }
    }
    
    
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
    
    
    //MARK: Learn the url for the users document directory so their annotations can be store there.
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
