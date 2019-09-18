//
//  NumPadTimeTableViewCell.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/17.
//  Copyright © 2019 lieon. All rights reserved.
//

import UIKit

class NumPadTimeTableViewCell: UITableViewCell {
    var timer: ACTimer!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timer = ACTimer(1, isRepeat: true, eventHandler: configDate)
    }
    
    fileprivate func configDate() {
        let date = Date()
        let caledar = Calendar.current
        let dateComponents = caledar.dateComponents(in: TimeZone.current, from: date)
        let year = dateComponents.year
        let month = dateComponents.month
        let day = dateComponents.day
        let hour = dateComponents.hour
        let mintues = dateComponents.minute
        let seconds = dateComponents.second
        let weekDay = dateComponents.weekdayOrdinal ?? 0
        dateLabel.text = "\(year ?? 0)年\(month ?? 0)月\(day ?? 0)日"
        timeLabel.text = "\(hour ?? 0):\(mintues ?? 0):\(seconds ?? 0)"
        weekLabel.text = String.numToWeekDay(weekDay)
        let formater = DateFormatter()
        formater.amSymbol = "上午"
        formater.pmSymbol = "下午"
        formater.dateFormat = "aaa"
        let dateStr = formater.string(from: date)
        monLabel.text = dateStr
    }
}
