//
//  TableViewDelegate.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/11/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class TableViewDelegate: NSObject, UITableViewDelegate {
    
    public let table: Table
    public var didScroll: ((UIScrollView) -> Void)?

    public init(table: Table) {
        self.table = table
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return table.row(at: indexPath).height?(tableView, indexPath) ?? tableView.rowHeight
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return table.row(at: indexPath).estimatedHeight?(tableView, indexPath) ?? tableView.estimatedRowHeight
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        table.row(at: indexPath).willDisplay?(tableView, cell, indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.row(at: indexPath).didSelect?(tableView, indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let footer = table.sections[safe: section] else { return 0.01 }
        return (footer.footer?.height?(tableView, section)) ?? 0.01
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = table.sections[safe: section] else { return 0.01 }
        return (header.header?.height?(tableView, section)) ?? 0.01
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let section = table.sections[safe: section] else { return nil }
        if let footer = section.footer, let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: footer.reuseIdentifier) {
            footer.configure?(view)
            return view
        } else {
            return nil
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = table.sections[safe: section] else { return nil }
        if let header = section.header, let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: header.reuseIdentifier) {
            header.configure?(view)
            return view
        } else {
            return nil
        }
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView)
    }
}
