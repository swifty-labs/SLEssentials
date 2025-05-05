//
//  KeyboardAccessoryView.swift
//
//
//  Created by Mirko Licanin on 17.1.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit

final class KeyboardAccessoryView: UIView {
	// MARK: - Properties

	var onFrameChange: VoidReturnClosure<CGRect>?

	private var observation: NSKeyValueObservation?

	// MARK: - Lifecycle

	override func willMove(toSuperview newSuperview: UIView?) {
		observation = newSuperview?.observe(\.center) { [weak self] view, _ in
			guard let self else { return }
			self.onFrameChange?(view.frame)
		}
	}
}
