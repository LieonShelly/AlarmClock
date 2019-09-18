//
//  HomeViewController.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/18.
//  Copyright © 2019 lieon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    fileprivate var pageInex: Int = 0
    fileprivate lazy var pageVC: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        return pageVC
    }()
    
    fileprivate lazy var timeClockVC: TimeColckViewController = {
        let timeClockVC = TimeColckViewController()
        return timeClockVC
    }()
    
    fileprivate lazy var alarmVC: AlarmClockViewController = {
        let alarmVC = AlarmClockViewController()
        return alarmVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

}


extension HomeViewController {
    fileprivate func configUI() {
        pageVC.view.frame = view.bounds
        pageVC.isDoubleSided = false
        pageVC.dataSource = self
        view.addSubview(pageVC.view)
        addChild(pageVC)
        pageVC.setViewControllers([timeClockVC], direction: .forward, animated: false, completion: nil)
    }
}

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if pageInex == 0 {
             pageInex = 1
            return timeClockVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if pageInex == 1 {
            pageInex = 0
            return alarmVC
        }
        return nil
    }
}
