//
//  ViewController.swift
//  PomodoroTimer
//
//  Created by Caitlin Wu on 2021-11-15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var workTime: UIDatePicker!
    @IBOutlet var restTime: UIDatePicker!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var pomodoroLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var backgroundColour = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if backgroundColour == 0 {
            let layer = CALayer()
            layer.frame = view.bounds
            layer.backgroundColor = UIColor(red: 162.0 / 255.0, green: 195.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0).cgColor
//            pomodoroLabel.textColor = UIColor.white
            view.layer.insertSublayer(layer, at: 0)
        } else {
            let layer = CALayer()
            layer.frame = view.bounds
            layer.backgroundColor = UIColor(red: 93.0 / 255.0, green: 123.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0).cgColor
            view.layer.insertSublayer(layer, at: 0)
        }
        
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.tintColor = UIColor.black
        segmentedControl.selectedSegmentIndex = backgroundColour
    }
    
    @IBAction func getStartedTapped() {
        let pickedWorkTime = workTime.date
        let pickedRestTime = restTime.date
            
        guard let vc = storyboard?.instantiateViewController(identifier: "timer_vc") as? TimerViewController else {
            return
        }
        vc.workTime = pickedWorkTime
        vc.restTime = pickedRestTime
        vc.isWorking = true
        vc.backgroundColour = self.backgroundColour
        present(vc, animated: true)
    }
    
    @IBAction func backgroundChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let layer = CALayer()
            layer.frame = view.bounds
            layer.backgroundColor = UIColor(red: 162.0 / 255.0, green: 195.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0).cgColor
//            pomodoroLabel.textColor = UIColor.white
            view.layer.sublayers?[0].removeFromSuperlayer()
            view.layer.insertSublayer(layer, at: 0)
            backgroundColour = 0
        case 1:
            let layer = CALayer()
            layer.frame = view.bounds
            layer.backgroundColor = UIColor(red: 93.0 / 255.0, green: 123.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0).cgColor
            pomodoroLabel.textColor = UIColor.white
            view.layer.sublayers?[0].removeFromSuperlayer()
            view.layer.insertSublayer(layer, at: 0)
            backgroundColour = 1
        default:
            break
        }
    } 
}


