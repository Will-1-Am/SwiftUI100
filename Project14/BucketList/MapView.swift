//
//  MapView.swift
//  BucketList
//
//  Created by William Spanfelner on 01/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import MapKit

/*
 MARK: typealias is Swift’s way of renaming existing types, which is usually done to make them easier to remember.
 */

struct MapView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView { //MapView.UIViewType
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation1 = MKPointAnnotation()
        annotation1.title = "London"
        annotation1.subtitle = "Capital of England"
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        
        let annotation2 = MKPointAnnotation()
        annotation2.title = "Athens"
        annotation2.subtitle = "Capital of Greece"
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 37.9794500, longitude: 23.7162200)
        
//        mapView.addAnnotation(annotation1)
        mapView.addAnnotations([annotation1, annotation2])
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil) //reuseIdentifier: "pin" this can be set to any string and is recommended as creating views is expensive
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator { //MapView.Coordinator
        Coordinator(self)
    }

}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
