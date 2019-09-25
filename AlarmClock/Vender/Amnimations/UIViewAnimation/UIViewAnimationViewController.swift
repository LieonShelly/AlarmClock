//
//  UIViewAnimationViewController.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/25.
//  Copyright © 2019 lieon. All rights reserved.
//

import UIKit

class UIViewAnimationViewController: UIViewController {
     @IBOutlet var loginButton: UIButton!
     @IBOutlet var heading: UILabel!
     @IBOutlet var username: UITextField!
     @IBOutlet var password: UITextField!
     
     @IBOutlet var cloud1: UIImageView!
     @IBOutlet var cloud2: UIImageView!
     @IBOutlet var cloud3: UIImageView!
     @IBOutlet var cloud4: UIImageView!
    var statusPosition: CGPoint = .zero
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    var animationContainerView: UIView!
    let newView = UIImageView(image: UIImage(named: "banner"))
    let status = UIImageView(image: UIImage(named: "banner"))
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true

        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)

        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)

        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
        
        loginButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        statusPosition = status.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.heading.center.x -= self.view.bounds.width
        self.username.center.x -= self.view.bounds.width
        self.password.center.x -= self.view.bounds.width
        cloud1.alpha = 0
        cloud2.alpha = 0
        cloud3.alpha = 0
        cloud4.alpha = 0
        loginButton.center.y += 30
        loginButton.alpha = 0
       
    }
    
    @objc fileprivate func login() {
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.bounds.size.width += 80
        }, completion: { _ in
            self.showMessage(index: 0)
        })
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60
            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1)
            self.spinner.center = CGPoint(x: 40, y: self.loginButton.frame.size.height / 2)
            self.spinner.alpha = 1
        }, completion: nil)
    }
    /**
     可以做动画相关的UI属性：
     1> position: frmae, bounds, center
     2> size
     3> appearance: backgroundColor, alpha
     4> transform: rotation, scale, postion of view
     
     Animation Options:
     1> Repeating: .repeat, .autoreverse
     2> animations easing: .curveLinear, .curveEaseIn, .curveEaseOut, .curveEaseInOut
     
     Springs Animation:(弹性动画)
     UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
                   self.loginButton.center.y += 60
                   self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1)
     }, completion: nil)
     1> damping: 弹性系数
     2> initialSpringVelocity: 初始弹性速度
     */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cloudEaseAnimation()
        springAnimation()
    }
    
    fileprivate func springAnimation() {
        UIView.animate(withDuration: 3, delay: 0.2, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
                self.heading.center.x += self.view.bounds.width
             }, completion: nil)
        UIView.animate(withDuration: 3, delay: 0.3, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
                self.username.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 3, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
                self.password.center.x += self.view.bounds.width
              }, completion: nil)
        UIView.animate(withDuration: 3, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.loginButton.center.y -= 30
            self.loginButton.alpha = 1
        }, completion: nil)
        
    }


    fileprivate func easeAnimation() {
         UIView.animate(withDuration: 0.5) {
              self.heading.center.x += self.view.bounds.width
          }
          UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
              self.username.center.x += self.view.bounds.width
          }, completion: nil)
          UIView.animate(withDuration: 0.5, delay: 0.4, options: [.curveEaseInOut], animations: {
              self.password.center.x += self.view.bounds.width
          }, completion: nil)
          
    }
    
    fileprivate func cloudEaseAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseInOut], animations: {
                  self.cloud1.alpha = 1
              }, completion: nil)
              UIView.animate(withDuration: 0.5, delay: 0.7, options: [.curveEaseInOut], animations: {
                  self.cloud2.alpha = 1
                    }, completion: nil)
              UIView.animate(withDuration: 0.5, delay: 0.9, options: [.curveEaseInOut], animations: {
                  self.cloud3.alpha = 1
                    }, completion: nil)
              UIView.animate(withDuration: 0.5, delay: 1.1, options: [.curveEaseInOut], animations: {
                  self.cloud4.alpha = 1
                  }, completion: nil)
    }
    /*
     transition 使用场景
     1> adding a new view
     2> removing a view
     3> show/hidden a view
     */
    
    fileprivate func transitionsAnimations() {

        /// 1. add a new view
        UIView.transition(with: animationContainerView, duration: 0.33, options: [.curveEaseInOut, .transitionFlipFromLeft], animations: {
            self.animationContainerView.addSubview(self.newView)
        }, completion: nil)

        /// 2. removing a view
        UIView.transition(with: animationContainerView, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
            self.newView.removeFromSuperview()
        }, completion: nil)

        /// 3.hide the view via transition
        UIView.transition(with: newView, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
            self.newView.isHidden = true
        }, completion: nil)
    }


    fileprivate func showMessage(index: Int) {
        label.text = messages[index]
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionCurlUp], animations: {
            self.status.isHidden = false
        }) { (isCompete) in
            delay(0.2) {
                if index < self.messages.count - 1 {
                    self.removeMessage(index: index)
                } else {
                    self.resetForm()
                }
            }
        }
    }

    
    fileprivate func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.width
        }, completion:  { _ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.showMessage(index: index + 1)
        })
    }
    
    fileprivate func resetForm() {
        UIView.transition(with: self.status, duration: 0.2, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden = true
        }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.spinner.center = CGPoint(x: -20, y: 16)
            self.spinner.alpha = 0
            self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            self.loginButton.bounds.size.width -= 80
            self.loginButton.center.y -= 60
        }, completion: nil)
    }
}


// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}
