//
//  ImagePicker.swift
//
//
//  Created by Mirko Licanin on 24.12.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit
import PhotosUI
import SLEssentials

#if os(iOS)
public protocol ImagePicker {
	var onImagesSelect: VoidReturnClosure<[UIImage]>? { get set }
	var onCloseSelect: NoArgsClosure? { get set }
	var onCameraPermissionDenied: NoArgsClosure? { get set }
	var selectionLimit: Int { get set }
	func show(for type: ImagePickerType, in controller: UIViewController)
	func isAvailable(for type: ImagePickerType) -> Bool
}

public extension ImagePicker {
	var onCloseSelect: NoArgsClosure? { nil }
	var onCameraPermissionDenied: NoArgsClosure? { nil }
	var selectionLimit: Int { 1 }
	func isAvailable(for type: ImagePickerType) -> Bool { true }
}

public enum ImagePickerType {
	case camera, library
}

public final class SystemImagePicker: NSObject, ImagePicker {
	// MARK: - Properties

	public var onImagesSelect: VoidReturnClosure<[UIImage]>?
	public var onCloseSelect: NoArgsClosure?
	public var onCameraPermissionDenied: NoArgsClosure?
	public var selectionLimit = 1
	
	private var loadedImages = [UIImage]()
	
	// MARK: - Public methods
	
	public func show(for type: ImagePickerType, in controller: UIViewController) {
		switch type {
		case .camera:
			presentCameraPicker(in: controller)
		case .library:
			presentLibraryPicker(in: controller)
		}
	}
	
	public func isAvailable(for type: ImagePickerType) -> Bool {
		switch type {
		case .camera:
			return UIImagePickerController.isSourceTypeAvailable(.camera)
		case .library:
			if #available(iOS 14, *) {
				return true
			} else {
				return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
			}
		}
	}
	
	// MARK: - Private methods
	
	private func presentCameraPicker(in controller: UIViewController) {
		let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
		guard authorizationStatus != .denied && authorizationStatus != .restricted else {
			onCameraPermissionDenied?()
			return
		}
		presentImagePickerController(in: controller, with: .camera)
	}
	
	private func presentLibraryPicker(in controller: UIViewController) {
		if #available(iOS 14, *) {
			presentPickerViewController(in: controller)
		} else {
			presentImagePickerController(in: controller, with: .photoLibrary)
		}
	}
	
	private func presentImagePickerController(in controller: UIViewController, with sourceType: UIImagePickerController.SourceType) {
		let controllerImagePicker = UIImagePickerController()
		controllerImagePicker.delegate = self
		controllerImagePicker.sourceType = sourceType
		controller.present(controllerImagePicker, animated: true, completion: nil)
	}
	
	@available(iOS 14, *)
	private func presentPickerViewController(in controller: UIViewController) {
		var config = PHPickerConfiguration()
		config.filter = .images
		config.selectionLimit = selectionLimit
		let controllerPicker = PHPickerViewController(configuration: config)
		controllerPicker.delegate = self
		controller.present(controllerPicker, animated: true, completion: nil)
	}
}

// MARK: - UIImagePickerControllerDelegate
extension SystemImagePicker: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		picker.dismiss(animated: true) { [weak self] in
			guard let self else { return }
			guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
				self.onCloseSelect?()
				return
			}
			self.onImagesSelect?([image])
		}
	}

	public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true) { [weak self] in
			guard let self else { return }
			self.onCloseSelect?()
		}
	}
}

// MARK: - PHPickerViewControllerDelegate
@available(iOS 14, *)
extension SystemImagePicker: PHPickerViewControllerDelegate {
	public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
		let itemProviders = results.map(\.itemProvider).filter { $0.canLoadObject(ofClass: UIImage.self) }
		loadImages(from: itemProviders, with: 0) {
			picker.dismiss(animated: true) { [weak self] in
				guard let self else { return }
				!self.loadedImages.isEmpty ? self.onImagesSelect?(self.loadedImages) : self.onCloseSelect?()
				self.loadedImages.removeAll()
			}
		}
	}
	
	private func loadImages(from itemProviders: [NSItemProvider], with index: Int, completion: @escaping NoArgsClosure) {
		guard !itemProviders.isEmpty else { completion(); return }
		itemProviders[index].loadObject(ofClass: UIImage.self) { [weak self] image, _ in
			guard let self, let image = image as? UIImage else { return }
			self.loadedImages.append(image)
			guard index != itemProviders.count - 1 else { DispatchQueue.main.async { completion() }; return }
			self.loadImages(from: itemProviders, with: index + 1, completion: completion)
		}
	}
}
#endif
