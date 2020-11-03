//
//  ContentView.swift
//  Instafilter - Challenge 1 - Try making the Save button show an error if there was no image in the image view.
//
//  Created by William Spanfelner on 24/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
//MARK: CoreImage & CoreImage.CIFilterBuiltins are necessary imports to apply filters to an image


struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    /* */
    //MARK: Track wheter the ImagePicker is displayed and inputImage serves to store the UIImage object declared as a binding property.
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    /* */
    //MARK: In order to render a CIImage to a CGImage a context is req'd and since this is expensive, it should be kept alive.  A filter is also req'd and it will be made flexible with a state property.
    //MARK: currentFilter should be type specific to ensure that any changes applied will apply across the board. However, doing this means that we will lose conformance to the SepiaTone protocol which in turn means that our intensity parameter will no longer be accessible in the way that it is now…
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    /* */
    //MARK: A property for storing the state of the Action Sheet that contains all the filter options
    @State private var showingFilterSheet = false
    /* */
    //MARK: A property for saving an intermediate image
    @State private var processedImage: UIImage?
    /* */
    //MARK: Challenge 1 - state property for whether there is an image to save
    @State private var noImage = false
    
    var body: some View {
        
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                    
                    //Display the image
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a photo")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    //Select an image
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)
                
                HStack{
                    Button("Change filter") {
                        //change filter
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        //save the picture
                        /* */
                        //MARK: Challenge 1 - Check whether image is nil
                        guard self.image != nil else {
                            self.noImage = true
                            return
                        }
                        
                        guard let processedImage = self.processedImage else { return }
                        
                        let imageSaver = NewImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
                
                //            BlurredTextCustomBindingView()
                //            ActionSheetView()
                //            CoreImageView()
                //                ImagePickerView()
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            
            //MARK: Challenge 1 - alert for the case where no image was selected for saving.
            .alert(isPresented: $noImage) {
                Alert(title: Text("Error"), message: Text("Could not save - no image selected"), dismissButton: .default(Text("Continue")))
            }

            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                NewImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                //action sheet here
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")){ self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")){ self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")){ self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")){ self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")){ self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")){ self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")){ self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    //MARK: When the ImagePicker is dismissed loadImage will be called.
    func loadImage() {
        guard let inputImage = inputImage else { return }
//        image = Image(uiImage: inputImage)
        //MARK: the above line was fine for testing but now requirements have changed.  The applyProcessing method will perform its magic from here.
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    //MARK: Now that the CIContext and currentFilter is declared, a method for processing the image follows that will set the filter's intensity, read the output image from the filter, render the image with the CIContext and insert the result into the image property so that it is visible on screen.
    func applyProcessing() {
//        currentFilter.intensity = Float(filterIntensity)
        //MARK: Since currentFilter is now a CIFilter type the above line needs to be changed as follows to set the intensity parameter especially that it is no longer conformant to the SepiaTone protocol
//        currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        //MARK: Unfortunately, the above line will cause the code to crash since there is no intensity value to set in the other filters.  So, the input keys for the filter need to be read in order to apply the value from the slider to the appropriate property.
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            //MARK: Storing the uiImage away for use later
            processedImage = uiImage
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
