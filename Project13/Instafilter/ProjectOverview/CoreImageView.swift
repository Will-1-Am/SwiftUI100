//
//  CoreImageView.swift
//  Instafilter
//
//  Created by William Spanfelner on 25/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImageView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        /*
         If image is nil then loadImage won't execute
         */
        .onAppear(perform: loadImage)
    }
    func loadImage() {
        
        //MARK: The Image view as it stands cannot be used in CoreImage because Image is a SwiftUI view.  It must be treated initially as a UIImage and then needs to be converted to a CIIMage type for use within CoreImage.
//        image = Image("coffee")
        guard let inputImage = UIImage(named: "coffee") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
  
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)
        
        
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.radius = 200
        
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 100
        
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1
        
        //get a CIImage from the filter or exit if that fails
        guard let outputImage =  currentFilter.outputImage else { return }
        
        //attempt to get a CGImage from the CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            
            //convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            
            //and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageView()
            .preferredColorScheme(.dark)
    }
}
