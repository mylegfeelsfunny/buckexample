//
//  TableViewDataSource.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/11/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class TableViewDataSource: NSObject, UITableViewDataSource {
    
    public let table: Table
    
    public init(table: Table) {
        self.table = table
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.sections[safe: section]?.rows.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = table.row(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        row.configure?(cell)
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return table.sections.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return table.sections[safe: section]?.header?.title?()
    }
}
