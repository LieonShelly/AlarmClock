//
//  ACTimer.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/16.
//  Copyright © 2019 lieon. All rights reserved.
//

import Foundation

class ACTimer: NSObject {
    fileprivate var timer: DispatchSourceTimer!
    
    convenience init(_ timerInterval: Double,
                     isRepeat: Bool,
                     queue: DispatchQueue? = DispatchQueue.main,
                     eventHandler:(() -> Void)?) {
        self.init()
        timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags.init(rawValue: 0), queue: queue)
        timer.schedule(deadline: .now(), repeating: timerInterval)
        timer.setEventHandler {[weak self] in
            guard let weakSelf = self else {
                return
            }
            if !isRepeat {
                weakSelf.timer.cancel()
            }
            eventHandler?()
        }
        timer.resume()
    }
    
    func cancel() {
        if !timer.isCancelled {
            timer.cancel()
        }
    }
    
    deinit {
        debugPrint("ACTimer - deinit")
    }
    
}
