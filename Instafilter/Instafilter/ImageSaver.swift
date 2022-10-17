//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Erik Radicheski da Silva on 17/10/22.
//

import UIKit

class ImageSave: NSObject {
    
    private var image: UIImage
    
    init(_ image: UIImage) {
        self.image = image
    }
    
    func writeToPhotoAlbum() {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc private func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
}
