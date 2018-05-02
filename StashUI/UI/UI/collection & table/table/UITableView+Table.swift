//
//  UITableView+Table.swift
//  StashUI
//
//  Created by Anton Gladkov on 1/22/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit

private var tableViewDataSourceKey = "TableViewDataSource"
private var tableViewDelegateKey = "TableViewDataSource"

extension UITableView {

    public func register(table: Table) {
        table.sections.forEach { section in
            section.rows.forEach { item in
                item.registration.map(register)
            }

            if let header = section.header {
                header.registration.map(register)
            }

            if let footer = section.footer {
                footer.registration.map(register)
            }
        }
    }

    public func configure(with table: Table) {
        register(table: table)

        tableViewDataSource = TableViewDataSource(table: table)
        tableViewDelegate = TableViewDelegate(table: table)

        dataSource = tableViewDataSource
        delegate = tableViewDelegate
        
        reloadData()
    }

    public func configured(with table: Table) -> UITableView {
        configure(with: table)
        return self
    }

    private var tableViewDataSource: TableViewDataSource {
        get {
            return objc_getAssociatedObject(self, &tableViewDataSourceKey) as! TableViewDataSource
        }

        set {
            objc_setAssociatedObject(self, &tableViewDataSourceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var tableViewDelegate: TableViewDelegate {
        get {
            return objc_getAssociatedObject(self, &tableViewDelegateKey) as! TableViewDelegate
        }

        set {
            objc_setAssociatedObject(self, &tableViewDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
