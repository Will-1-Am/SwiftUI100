//
//  ImagePickerView.swift
//  Instafilter
//
//  Created by William Spanfelner on 25/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI

struct ImagePickerView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    //MARK: Integrating the new ImagePicker requires a new @State property
    @State private var inputImage: UIImage?
    

    var body: some View {
        VStack {
            image?
            .resizable()
            .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
            //MARK: The ImagePicker call needs updating to take the new inputImage property and the sheet modifier needs an additional parameter for dismissing the sheet.
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            //ImagePicker()
            ImagePicker(image: self.$inputImage)
        }
    }
    
    //MARK: When inputImage changes, loadImage will activate - a property observer won't work here since changes will be ignored, in effect, by SwiftUI.
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        //MARK: To save the image selected by the user immediately
        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)

        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
            .previewLayout(.sizeThatFits).padding()
            .preferredColorScheme(.dark)
    }
}
