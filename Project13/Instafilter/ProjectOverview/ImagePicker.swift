//
//  ImagePicker.swift
//  Instafilter
//
//  Created by William Spanfelner on 25/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    ///MARK: the typealias line can be deleted, the compiler will complain until the struct conforms to the UIViewControllerRepresentable protocol - it will add stubs if desired
    typealias UIViewControllerType = UIImagePickerController

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        //MARK: Notify the coordinator that a seleciton was made
        picker.delegate = context.coordinator
        
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    //MARK: This struct as it is allows the ImagePicker to display selections but once the user selects a photo, the Picker is dismissed and there is no update stating what the user selected.  A SwiftUI Coordinator needs to be implemented to provide this function.
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        //MARK: parent and the initializer deliver the necessary information to the Coordinator when an image is selected.
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                print(info[.mediaMetadata])//What does this do?
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
        //MARK: This passes the ImagePicker struct to the Coordinator class
    }
    
    //MARK: @Binding will report the selection made with the ImagePicker to whatever presented the ImagePicker - in this case our sheet in ImagePickerView.
    //MARK: @Environment property allows the view to be dismissed programatically
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
}
