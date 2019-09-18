//
//  AlarmClockViewController.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/18.
//  Copyright © 2019 lieon. All rights reserved.
//

import UIKit

class AlarmClockViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    struct UISize {
        static let clockCellHeight: CGFloat = UIScreen.main.bounds.height / 3.0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

}

extension AlarmClockViewController: ViewControllerable {
    func configUI() {
         view.backgroundColor = .red
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.registerNibWithCell(TimePickerTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}



extension AlarmClockViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueCell(TimePickerTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueCell(UITableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

extension AlarmClockViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UISize.clockCellHeight
    }
}
