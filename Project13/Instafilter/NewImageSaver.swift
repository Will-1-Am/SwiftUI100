//
//  ImageSaver.swift
//  Instafilter
//
//  Created by William Spanfelner on 28/11/2019.
//  Copyright © 2019 William Spanfelner. All rights reserved.
//

import UIKit

class NewImageSaver: NSObject {
    //MARK: The following properties represent success and failure respectively
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        //save complete
        
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
