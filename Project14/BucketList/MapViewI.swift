//
//  MapViewI.swift
//  BucketList
//
//  Created by William Spanfelner on 02/12/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import MapKit

struct MapViewI: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotations: [MKPointAnnotation]
    
    //MARK: Properties for what was selected and whether to selection details or not.  These are binding properties since they will form a bridge between MKMapView and SwiftUI.
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewI
        
        init(_ parent: MapViewI) {
           self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            //this is our unique identifier for view reuse
            let identifier = "Placemark"
            
            //attempt to find a cell to recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                //no reusable view found - make a new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                //allow this to show popup info
                annotationView?.canShowCallout = true
                
                //attach an information button to the view
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                //a view is available - give it new information
                annotationView?.annotation = annotation
            }
            
            //whether the view is new or recycled send it back
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placemark = view.annotation as? MKPointAnnotation else { return }
            
            parent.selectedPlace = placemark
            parent.showingPlaceDetails = true
        }
    }
}


//MARK: Adding the centerCoordinate binding property above, immediatley breaks the preview code and while that is not of huge consequence, since MapViews don't work particularly well in the canvas view.  To fix that the following extension to MKPointAnnotation holds some constant data to satisfy the preview.
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home of 2012 Summer Olympics"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapViewI_Previews: PreviewProvider {
    static var previews: some View {
        MapViewI(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), annotations: [MKPointAnnotation.example], selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false))
    }
}
