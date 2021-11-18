//
//  TimerViewController.swift
//  PomodoroTimer
//
//  Created by Caitlin Wu on 2021-11-15.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet var countDown: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var backgroundColour = 0
    
    var workTime = Date()
    var restTime = Date()
    
    var isWorking:Bool = true
    var timerCounting:Bool = true
    
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    
    var rounds: Int = 0
    var done: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getTimeComponents(time: workTime)
        createCountDown()
//        while(done == false) {}
//        createRestCountDown()
        if backgroundColour == 0 {
            getLightBackground()
        } else if backgroundColour == 1 {
            getDarkBackground()
        }
        segmentedControl.selectedSegmentIndex = backgroundColour
    }
    
    private func getTimeComponents(time: Date) {
        let calendar = Calendar.current
        hours = calendar.component(.hour, from: time)
        mins = calendar.component(.minute, from: time)
        secs = calendar.component(.second, from: time)
    }
    
    private func createCountDown() {
            getTimeComponents(time: workTime)
            updateLabel()
            startTimer()
            self.isWorking = false
        done = true
    }

//    private func createRestCountDown() {
//        getTimeComponents(time: restTime)
//        updateLabel()
//        startRestTimer()
//    }
    
    private func updateLabel() {
        if (hours == 0) {
            countDown.text = String(format: "%02d:%02d", mins, secs)
        } else {
            countDown.text = String(format: "%02d:%02d:%02d", hours, mins, secs)
        }
    }
    
    private func startTimer() {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                if (self.timerCounting) {
                    if self.secs > 0 {
                        self.secs -= 1
                    } else if self.mins > 0 && self.secs == 0 {
                        self.mins -= 1
                        self.secs = 59
                    } else if self.hours > 0 && self.mins == 0 && self.mins == 0 {
                        self.hours -= 1
                        self.mins = 59
                        self.secs = 59
                    }
                }
                self.updateLabel()
                if (self.hours == 0 && self.mins == 0 && self.secs == 0) {
                    self.timerCounting = false
                    timer.invalidate()
                }
            })
    }
    
    @IBAction func pauseTimerTapped(_ sender: Any) {
        if timerCounting == true {
            timerCounting = false
        } else if timerCounting == false {
            timerCounting = true
        }
    }

    
    @IBAction func endTimeTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "main_vc") as? ViewController else {
            return
        }
        vc.backgroundColour = self.backgroundColour
        present(vc, animated: true)
    }
    
    @IBAction func backgrounController(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let layer = CALayer()
            layer.frame = view.bounds
            layer.backgroundColor = UIColor(red: 162.0 / 255.0, green: 195.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0).cgColor
            view.layer.sublayers?[0].removeFromSuperlayer()
            view.layer.insertSublayer(layer, at: 0)
            backgroundColour = 0
        case 1:
            let layer = CALayer()
            layer.frame = view.bounds
            layer.backgroundColor = UIColor(red: 93.0 / 255.0, green: 123.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0).cgColor
            view.layer.sublayers?[0].removeFromSuperlayer()
            view.layer.insertSublayer(layer, at: 0)
            backgroundColour = 1
        default:
            break
        }
    }
    
    private func getLightBackground() {
        let layer = CALayer()
        layer.frame = view.bounds
        layer.backgroundColor = UIColor(red: 162.0 / 255.0, green: 195.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0).cgColor
        backgroundColour = 0
            view.layer.insertSublayer(layer, at: 0)
    }

    private func getDarkBackground() {
        let layer = CALayer()
        layer.frame = view.bounds
        layer.backgroundColor = UIColor(red: 93.0 / 255.0, green: 123.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0).cgColor
        backgroundColour = 1
        view.layer.insertSublayer(layer, at: 0)
    }
    

}
