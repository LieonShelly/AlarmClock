//
//  TimeColckViewController.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/18.
//  Copyright © 2019 lieon. All rights reserved.
//

import UIKit

class TimeColckViewController: UIViewController {
    @IBOutlet weak var addBtnBottom: NSLayoutConstraint!
    @IBOutlet weak var addBtn: UIButton!
    struct UISize {
        static let clockCellHeight: CGFloat = UIScreen.main.bounds.height / 3.0
    }
    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var popMenu: PopMenuViewController = {
         let popMenu = PopMenuViewController()
        return popMenu
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    @IBAction func addBtnAction(_ sender: Any) {
        popMenu.showOrDismiss()
    }
}

extension TimeColckViewController: ViewControllerable {
    func configUI() {
         view.backgroundColor = .yellow
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.registerNibWithCell(NumPadTimeTableViewCell.self)
        tableView.registerClassWithCell(UITableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        addChild(popMenu)
        let popHeight: CGFloat = addBtn.frame.origin.y
        popMenu.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: popHeight)
        popMenu.view.isHidden = true
        view.addSubview(popMenu.view)
    }
}

extension TimeColckViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueCell(NumPadTimeTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueCell(UITableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

extension TimeColckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UISize.clockCellHeight
    }
}


