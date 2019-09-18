//
//  AlarmClockTests.swift
//  AlarmClockTests
//
//  Created by lieon on 2019/9/16.
//  Copyright © 2019 lieon. All rights reserved.
//

import XCTest
@testable import AlarmClock
import Foundation

class AlarmClockTests: XCTestCase {

    var timer: ACTimer?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDispatchTimer() {
        let timer = ACTimer(1, isRepeat: true) {
            print(Date().timeIntervalSince1970)
        }
        self.timer = timer
    }

    func testCalendar() {
        configTime()
    }
    
    fileprivate func configTime() {
        let date = Date()
        let caledar = Calendar.current
        let dateComponents = caledar.dateComponents(in: TimeZone.current, from: date)
        let year = dateComponents.year
        let month = dateComponents.month
        let day = dateComponents.day
        let hour = dateComponents.hour
        let mintues = dateComponents.minute
        let seconds = dateComponents.second
        XCTAssert(year == 2019)
        XCTAssert(month == 9)
        XCTAssert(day == 18)
        debugPrint("hour:\(hour ?? 0) - mintues:\(mintues ?? 0) - seconds:\(seconds ?? 0)")
        let formater = DateFormatter()
        formater.amSymbol = "上午"
        formater.pmSymbol = "下午"
        formater.dateFormat = "aaa"
        let dateStr = formater.string(from: date)
        debugPrint(dateStr)
    }
}
