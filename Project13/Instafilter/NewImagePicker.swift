//
//  NewImagePicker.swift
//  Instafilter
//
//  Created by William Spanfelner on 27/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation
import SwiftUI

struct NewImagePicker: UIViewControllerRepresentable {
    //MARK: @Environment property is req'd to be able to dismiss the view that will be presented.  @Binding property is req'd to have property changes passed to it.
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    //MARK: Swift will automatically insert the necessar stubs to conform to UIViewControllerRepresentable if the only line present in the struct is the following commented line:
//    typealias UIViewControllerType = UIImagePickerController
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NewImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<NewImagePicker>) {
        
    }
    /*
     MARK:  While the user can search for an image and select it to dismiss the view, nothing is done with the selection. UIKit uses a system of delegation to act upon a selection and SwiftUI calls this a Coordinator which can also provide additional functionality.  The parent is specified explicitly so that the coordinator knows where to pass any relevant interesting events.  The Coordinator class needs to conform to UINavigationControllerDelegate and UIImagePickerControllerDelegate in order to work with a UIImagePicker.  Coordinator also inherits from the base class of most UIKit types - NSObject.
     */
    
    //MARK: Now that the above is in place, the Coordinator class can be made the delegate of the picker above.
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: NewImagePicker
        
        init(_ parent: NewImagePicker) {
            self.parent = parent
        }
        
        //MARK: The functionality req'd when a user selects an image - a dictionary of info regarding the selection & setting the image property of the NewImagePicker parent and then dismiss the view.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    //MARK: To use the Coordinator an instance of it is required
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    

}
