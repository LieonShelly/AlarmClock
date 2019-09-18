//
//  Extensions.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/18.
//  Copyright © 2019 lieon. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    //MARK: - Cell
    func registerNibWithCell<T: UITableViewCell>(_ cell: T.Type) {
        register(UINib(nibName: String(describing: cell), bundle: nil), forCellReuseIdentifier: String(describing: cell))
    }
    
    func registerClassWithCell<T: UITableViewCell>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: String(describing: cell))
    }
    
    func dequeueCell<T: UITableViewCell>(_ cell: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell)) as! T
    }
    
    func dequeueCell<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! T
    }
    
    //MARK: - HeaderFooterView
    func registerNibWithHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerFooterView: T.Type) {
        register(UINib(nibName: String(describing: headerFooterView), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: headerFooterView))
    }
    
    func registerClassWithHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerFooterView: T.Type) {
        register(headerFooterView, forHeaderFooterViewReuseIdentifier: String(describing: headerFooterView))
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerFooterView: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: headerFooterView)) as! T
    }
}

extension String {
    static func numToWeekDay(_ num: Int) -> String {
        switch num {
        case 0:
            return "星期日"
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
        default:
           return ""
        }
    }
}
