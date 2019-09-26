//
//  FlyDemoViewController.swift
//  AlarmClock
//
//  Created by lieon on 2019/9/25.
//  Copyright © 2019 lieon. All rights reserved.
//

import UIKit
import QuartzCore

class FlyDemoViewController: UIViewController {
    enum AnimationDirection: Int {
      case positive = 1
      case negative = -1
    }

    let londonToParis = FlightData(
      summary: "01 Apr 2015 09:42",
      flightNr: "ZY 2014",
      gateNr: "T1 A33",
      departingFrom: "LGW",
      arrivingTo: "CDG",
      weatherImageName: "bg-snowy",
      showWeatherEffects: true,
      isTakingOff: true,
      flightStatus: "Boarding")

    let parisToRome = FlightData(
      summary: "01 Apr 2015 17:05",
      flightNr: "AE 1107",
      gateNr: "045",
      departingFrom: "CDG",
      arrivingTo: "FCO",
      weatherImageName: "bg-sunny",
      showWeatherEffects: false,
      isTakingOff: false,
      flightStatus: "Delayed")

    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var summaryIcon: UIImageView!
    @IBOutlet var summary: UILabel!
    @IBOutlet var flightNr: UILabel!
    @IBOutlet var gateNr: UILabel!
    @IBOutlet var departingFrom: UILabel!
    @IBOutlet var arrivingTo: UILabel!
    @IBOutlet var planeImage: UIImageView!
    @IBOutlet var flightStatus: UILabel!
    @IBOutlet var statusBanner: UIImageView!
    var snowView: SnowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adjust ui
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height/2
        
        //add the snow effect layer
        snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
        let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        changeFlight(to: londonToParis)
    }

    fileprivate func fade(imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
        UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            imageView.image = toImage
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.snowView.alpha = showEffects ? 1.0: 0.0
        }, completion: nil)
    }
    
    fileprivate func changeFlight(to data: FlightData, animated: Bool = false) {
        summary.text = data.summary
        if animated {
            fade(imageView: bgImageView,
                 toImage: UIImage(named: data.weatherImageName)!,
                 showEffects: data.showWeatherEffects)
            let direction: AnimationDirection = data.isTakingOff ? AnimationDirection.positive : AnimationDirection.negative
            cubeTransition(label: flightNr, text: data.flightNr, direction: direction)
            cubeTransition(label: gateNr, text: data.gateNr, direction: direction)
            
            let offsetDeparting = CGPoint(x: CGFloat(direction.rawValue * 80), y: 0.0)
            moveLabel(label: departingFrom, text: data.departingFrom, offset: offsetDeparting)
            
            let offsetArrving = CGPoint(x: 0.0, y: CGFloat(direction.rawValue * 50))
            moveLabel(label: arrivingTo, text: data.arrivingTo, offset: offsetArrving)
            
            transitionStatus(with: statusBanner, label: flightStatus, text: data.flightStatus)
                       
        } else {
            bgImageView.image = UIImage(named: data.weatherImageName)
            snowView.isHidden = !data.showWeatherEffects

            flightNr.text = data.flightNr
            gateNr.text = data.gateNr
            departingFrom.text = data.departingFrom
            arrivingTo.text = data.arrivingTo
            flightStatus.text = data.flightStatus
        }
        
        delay(3) {
            self.changeFlight(to: data.isTakingOff ? self.parisToRome : self.londonToParis, animated: true)
        }
    }
    
    fileprivate func cubeTransition(label: UILabel, text: String, direction: AnimationDirection) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = label.backgroundColor
        
        let auxLabelOffset = CGFloat(direction.rawValue) * ( label.frame.height / 2)
        auxLabel.transform = CGAffineTransform(translationX: 0.0, y: auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        label.superview?.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            auxLabel.transform = .identity
            label.transform = CGAffineTransform(translationX: 0.0, y: -auxLabelOffset).scaledBy(x: 1.0, y: 0.1)
        }) { (_) in
            label.text = auxLabel.text
            label.transform = .identity
            auxLabel.removeFromSuperview()
        }
    }
    
    fileprivate func moveLabel(label: UILabel, text: String, offset: CGPoint) {
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = .clear
        
        auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        auxLabel.alpha = 0
        view.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0
        }) { (_) in
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            auxLabel.transform = .identity
            auxLabel.alpha = 1
        }) { (_) in
            auxLabel.removeFromSuperview()
            label.text = text
            label.alpha = 1
            label.transform = .identity
        }
    }
    
    fileprivate func transitionStatus(with statusBanner: UIView, label: UILabel, text: String) {
        UIView.transition(with: statusBanner, duration: 0.5, options: [.curveEaseOut, .transitionFlipFromTop], animations: {
            label.text = text
        }, completion: { _ in
           
        })
               
    }
}


class SnowView: UIView {
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      
      let emitter = layer as! CAEmitterLayer
      emitter.emitterPosition = CGPoint(x: bounds.size.width / 2, y: 0)
      emitter.emitterSize = bounds.size
      emitter.emitterShape = .rectangle
      
      let emitterCell = CAEmitterCell()
      emitterCell.contents = UIImage(named: "flake.png")!.cgImage
      emitterCell.birthRate = 200
      emitterCell.lifetime = 3.5
      emitterCell.color = UIColor.white.cgColor
      emitterCell.redRange = 0.0
      emitterCell.blueRange = 0.1
      emitterCell.greenRange = 0.0
      emitterCell.velocity = 10
      emitterCell.velocityRange = 350
      emitterCell.emissionRange = CGFloat(Double.pi/2)
      emitterCell.emissionLongitude = CGFloat(-Double.pi)
      emitterCell.yAcceleration = 70
      emitterCell.xAcceleration = 0
      emitterCell.scale = 0.33
      emitterCell.scaleRange = 1.25
      emitterCell.scaleSpeed = -0.25
      emitterCell.alphaRange = 0.5
      emitterCell.alphaSpeed = -0.15
      
      emitter.emitterCells = [emitterCell]
    }
    
    required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
      return CAEmitterLayer.self
    }

}

struct FlightData {
  let summary: String
  let flightNr: String
  let gateNr: String
  let departingFrom: String
  let arrivingTo: String
  let weatherImageName: String
  let showWeatherEffects: Bool
  let isTakingOff: Bool
  let flightStatus: String
}
