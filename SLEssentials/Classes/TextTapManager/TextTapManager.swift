//
//  TextTapManager.swift
//  Pods-SLEssentials_Tests
//
//  Created by Vukasin on 07/09/2020.
//

import Foundation

public final class TextTapManager {
	// MARK: - Properties
	public var textTapHandler: ((NSAttributedString?) -> ())?
	
	let layoutManager = NSLayoutManager()
	let textContainer = NSTextContainer(size: .zero)
	var textStorage: NSTextStorage?
	var attributedText: NSAttributedString?
	
	// MARK: - Init
	
	public init() {}
	
	// MARK: - Public methods
	
	public func setup(for label: UILabel, with attributedText: NSAttributedString) {
		self.attributedText = attributedText
		setupLayoutManager()
		setupTextStorage(for: attributedText)
		setupTextContainer(for: label)
		setupTapGestureRecognizer(for: label)
	}
	
	// MARK: - Actions
	
	@objc
	func handleLabelTap(_ recognizer: UITapGestureRecognizer) {
		guard let label = recognizer.view else { return }
		let labelSize = label.bounds.size
		textContainer.size = labelSize
		
		let locationOfTouchInLabel = recognizer.location(in: label)
		let textBoundingBox = layoutManager.usedRect(for: textContainer)
		let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
										  y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
		let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
													 y: locationOfTouchInLabel.y - textContainerOffset.y)
		let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
															in: textContainer,
															fractionOfDistanceBetweenInsertionPoints: nil)
		textChunk(at: indexOfCharacter, completion: textTapHandler)
	}
	
	// MARK: - Private methods
	
	func setupLayoutManager() {
		layoutManager.addTextContainer(textContainer)
	}
	
	func setupTextStorage(for attributedText: NSAttributedString) {
		textStorage = NSTextStorage(attributedString: attributedText)
		textStorage?.addLayoutManager(layoutManager)
	}
	
	func setupTextContainer(for label: UILabel) {
		textContainer.lineFragmentPadding = 0.0
		textContainer.lineBreakMode = label.lineBreakMode
		textContainer.maximumNumberOfLines = label.numberOfLines
	}
	
	func setupTapGestureRecognizer(for label: UILabel) {
		label.isUserInteractionEnabled = true
		label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:))))
	}
	
	func textChunk(at index: Int, completion: ((NSAttributedString?) -> ())?) {
		guard let attributedText = attributedText else {
			completion?(nil)
			return
		}
		attributedText.enumerateAttributes(in: NSRange(location: 0, length: attributedText.length), options: []) { _, range, _ in
			guard NSLocationInRange(index, range) else { return }
			completion?(attributedText.attributedSubstring(from: range))
		}
	}
}
