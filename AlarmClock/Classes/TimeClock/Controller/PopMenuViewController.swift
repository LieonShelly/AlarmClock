//
//  PopMenuViewController.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/18.
//  Copyright © 2019 lieon. All rights reserved.
//

import UIKit

class PopMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    struct UISize {
        static let cellHeight: CGFloat = 50
    }
    fileprivate lazy var items: [PopMenuModel] = {
        let items = [PopMenuModel("", name: "闹钟"),
                     PopMenuModel("", name: "计时器"),
                     PopMenuModel("", name: "睡眠定时器"),
                     PopMenuModel("", name: "倒计时")]
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

}

extension PopMenuViewController: ViewControllerable {
    func configUI() {
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.registerNibWithCell(PopMenuTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.transform = CGAffineTransform(scaleX: 1, y: 0)
        tableView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
    }
    
    func showOrDismiss(_ animate: Bool = false) {
        if view.isHidden {
            view.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                 self.tableView.transform = CGAffineTransform(scaleX: 1, y: 1.2)
            }) { (isFinish) in
                if isFinish {
                    UIView.animate(withDuration: 0.1, animations: {
                        self.tableView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                }
            }
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                 self.tableView.transform = CGAffineTransform(scaleX: 1, y: 0)
            }) { (isFinish) in
                if isFinish {
                    self.view.isHidden = true
                }
            }
        }
       
    }
    

}

extension PopMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(PopMenuTableViewCell.self, for: indexPath)
        cell.label.text = items[indexPath.row].name
        cell.imageView?.image = UIImage(named: items[indexPath.row].iconName)
        return cell
    }
}

extension PopMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UISize.cellHeight
    }
}


