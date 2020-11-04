//
//  ContentView.swift
//  Instafilter - Challenge 2 - Make the Change Filter button change its title to show the name of the currently selected filter.
//
//  Created by William Spanfelner on 24/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    /* */
    //MARK: Challenge 2 - Create a computed property string for the selected currentFilter name
    private var currentFilterName: String {
        let filterName = String(currentFilter.name)
        if filterName.hasPrefix("CI") && image != nil {
            return String(filterName.dropFirst(2))
        }
        return "Change Filter"
    }
    
    @State private var showingFilterSheet = false
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
            /* */
            //MARK: Challenge 1 - alert for the case where no image was selected for saving.
            .alert(isPresented: $noImage) {
                Alert(title: Text("Error"), message: Text("Could not save - no image selected"), dismissButton: .default(Text("Continue")))
            }

            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                NewImagePicker(image: self.$inputImage)
            }
            
            .actionSheet(isPresented: $showingFilterSheet) {
                /* */
                // MARK: Challenge 2 - Insert the currentFilterName appropriately
                ActionSheet(title: Text("Current filter: \(currentFilterName)\nSelect a filter:"), buttons: [
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
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)

            processedImage = uiImage
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
