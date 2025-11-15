//
//  PhotoPickerViewModel.swift
//  ReHair
//
//  Created on 2025-11-15.
//

import SwiftUI
import PhotosUI

class PhotoPickerViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var showImagePicker: Bool = false
    @Published var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var showActionSheet: Bool = false

    func selectImageSource() {
        showActionSheet = true
    }

    func openCamera() {
        imageSourceType = .camera
        showImagePicker = true
    }

    func openPhotoLibrary() {
        imageSourceType = .photoLibrary
        showImagePicker = true
    }

    func reset() {
        selectedImage = nil
        showImagePicker = false
        showActionSheet = false
    }
}
