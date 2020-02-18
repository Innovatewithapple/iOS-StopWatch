//
//  ViewController.swift
//  StopWatch
//
//  Created by Tarun Meena on 18/02/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit
import HGCircularSlider

class ViewController: UIViewController {
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval = 60
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    let button3 = UIButton(type: .custom)
    let button2 = UIButton(type: .custom)
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    
    fileprivate func leftButton() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 40, y: 600, width: 80, height: 80)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red: 62/255, green: 62/255, blue: 62/255, alpha: 1.0)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0), for: .normal)
       // button.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        button.addTarget(self, action: #selector(thumbsUpButtonPressed), for: .touchUpInside)
        view.addSubview(button)
    }
    
    fileprivate func rightButton() {
        button2.frame = CGRect(x: 300, y: 600, width: 80, height: 80)
        button2.layer.cornerRadius = 0.5 * button2.bounds.size.width
        button2.clipsToBounds = true
        button2.backgroundColor = UIColor(red: 21/255, green: 45/255, blue: 29/255, alpha: 1.0)
        button2.setTitle("Start", for: .normal)
        button2.setTitleColor(UIColor(red: 81/255, green: 207/255, blue: 122/255, alpha: 1.0), for: .normal)
        // button.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        button2.addTarget(self, action: #selector(thumbsUpButtonPressed2), for: .touchUpInside)
        view.addSubview(button2)
    }
    
    fileprivate func pauseButton() {
        button3.frame = CGRect(x: 300, y: 600, width: 80, height: 80)
        button3.layer.cornerRadius = 0.5 * button3.bounds.size.width
        button3.clipsToBounds = true
        button3.backgroundColor = UIColor(red: 60/255, green: 35/255, blue: 9/255, alpha: 1.0)
        button3.setTitle("Pause", for: .normal)
        button3.setTitleColor(UIColor(red: 255/255, green: 146/255, blue: 51/255, alpha: 1.0), for: .normal)
        // button.setImage(UIImage(named:"thumbsUp.png"), for: .normal)
        button3.addTarget(self, action: #selector(thumbsUpButtonPressed2), for: .touchUpInside)
        view.addSubview(button3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        leftButton()
        rightButton()
        button3.isHidden = true
        pauseButton()
        drawBgShape()
        drawTimeLeftShape()
        // here you define the fromValue, toValue and duration of your animation
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        leftButton()
        rightButton()
    }
    
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX , y: view.frame.midY), radius:
            100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor.gray.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 15
        view.layer.addSublayer(bgShapeLayer)
    }
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX , y: view.frame.midY), radius:
            100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor.yellow.cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 15
        view.layer.addSublayer(timeLeftShapeLayer)
    }

    func addTimeLabel() {
        timeLabel = UILabel(frame: CGRect(x: view.frame.midX-50 ,y: view.frame.midY-25, width: 100, height: 50))
        timeLabel.textColor = .yellow
        timeLabel.font = UIFont(name: "Futura", size: 18)
        timeLabel.textAlignment = .center
        timeLabel.text = timeLeft.time
        view.addSubview(timeLabel)
    }
    
    @objc func updateTime() {
    self.timeLeft = endTime?.timeIntervalSinceNow ?? 0
    self.timeLabel.text = timeLeft.time
    }
    
   @objc func thumbsUpButtonPressed() {
    timer.invalidate()
    timeLabel.text = "00"
    button3.isHidden = true
    button2.isHidden = false
    print("thumbs up left button pressed")
    }
    
    @objc func thumbsUpButtonPressed2() {
        addTimeLabel()
        strokeIt.fromValue = 0
        strokeIt.toValue = 1
        strokeIt.duration = timeLeft
        timeLeftShapeLayer.add(strokeIt, forKey: nil)
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        button3.isHidden = false
        button2.isHidden = true
        print("thumbs up right button pressed")
    }
    
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
