//
//  Table.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/11/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public struct TableRow {
    public let reuseIdentifier: String
    public private(set) var registration: TableRegistration?
    
    public var configure: ((UITableViewCell) -> Void)?
    
    public var didSelect: ((UITableView, IndexPath) -> Void)?
    public var willDisplay: ((UITableView, UITableViewCell, IndexPath) -> Void)?
    public var height: ((UITableView, IndexPath) -> CGFloat)?
    public var estimatedHeight: ((UITableView, IndexPath) -> CGFloat)?
    
    public init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }

    public init<T: UITableViewCell>(_: T.Type) {
        let registration = TableRegistration(for: T.self)
        self.registration = registration
        self.reuseIdentifier = registration.reuseIdentifier
    }
}

public struct TableSection {
    public let header: TableSectionHeaderFooter?
    public let footer: TableSectionHeaderFooter?
    public let rows: [TableRow]
    
    public var height: ((UITableView, Int) -> CGFloat)?
    
    public init(rows: [TableRow], header: TableSectionHeaderFooter? = nil, footer: TableSectionHeaderFooter? = nil) {
        self.header = header
        self.rows = rows
        self.footer = footer
    }
}

public struct TableSectionHeaderFooter {
    public let reuseIdentifier: String
    public private(set) var registration: TableRegistration?

    public var configure: ((UITableViewHeaderFooterView) -> Void)?
    public var title: (() -> String)?

    public var height: ((UITableView, Int) -> CGFloat)?
    public var estimatedHeight: ((UITableView, Int) -> CGFloat)?

    public init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }

    public init<T: UITableViewHeaderFooterView>(_: T.Type) {
        let registration = TableRegistration(for: T.self)
        self.registration = registration
        self.reuseIdentifier = registration.reuseIdentifier
    }
}

public struct Table {
    public let sections: [TableSection]
    
    public init(sections: [TableSection]) {
        self.sections = sections
    }
    
    public init(section: TableSection) {
        self.sections = [section]
    }
    
    public func row(at indexPath: IndexPath) -> TableRow {
        return sections[indexPath.section].rows[indexPath.item]
    }
}
