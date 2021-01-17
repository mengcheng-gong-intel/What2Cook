//
//  ImagePickerView.swift
//  What2Cook
//
//  Created by Maizi Liao on 2021-01-16.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var materialImages: [MaterialImage]
    @Binding var isPresented: Bool
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(materialImages: $materialImages, isPresented: $isPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }
}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var materialImages: [MaterialImage]
    @Binding var isPresented: Bool
    
    init(materialImages: Binding<[MaterialImage]>, isPresented: Binding<Bool>) {
        self._materialImages = materialImages
        self._isPresented = isPresented
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            var materialImage = MaterialImage(image: image)
            if let url = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
                materialImage.imageUrl = url.absoluteURL
            }
            self.materialImages.append(materialImage)
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}
