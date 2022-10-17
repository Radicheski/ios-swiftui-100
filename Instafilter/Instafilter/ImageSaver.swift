//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Erik Radicheski da Silva on 17/10/22.
//

import UIKit

class ImageSave: NSObject {
    
    private var errorHandler: ((Error) -> Void)?
    private var successHandler: (() -> Void)?
    
    private var image: UIImage
    
    init(_ image: UIImage) {
        self.image = image
    }
    
    func writeToPhotoAlbum(successHandler: (() -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        self.successHandler = successHandler
        self.errorHandler = errorHandler
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc private func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
    
}
