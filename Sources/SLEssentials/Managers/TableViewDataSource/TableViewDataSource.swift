//
//  TableViewDataSource.swift
//
//
//  Created by Mirko Licanin on 20.8.20..
//  Copyright © 2020 SwiftyLabs. All rights reserved.
//

import UIKit

public final class TableViewDataSource<T, E: UITableViewCell>: NSObject, UITableViewDataSource {
	public typealias CellConfigurator = (T, E) -> Void

	// MARK: - Properties

	public var dataSource = [T]()

	private let cellConfigurator: CellConfigurator
	private let cellType: E.Type

	// MARK: - Initialization

	public init(cellType: E.Type, cellConfigurator: @escaping CellConfigurator) {
		self.cellType = cellType
		self.cellConfigurator = cellConfigurator
	}

	// MARK: - UITableViewDataSource

	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		dataSource.count
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard dataSource.count > indexPath.row else { return UITableViewCell() }

		let model = dataSource[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath)
		if let cell = cell as? E {
			cellConfigurator(model, cell)
		}
		return cell
	}
}
