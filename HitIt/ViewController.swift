//
//  ViewController.swift
//  BullsEye
//
//  Created by GIORGI's MacPro on 14.10.22.
//

import UIKit

class ViewController: UIViewController {

    var targetValue = 0
    var currentValue: Int = 50
    var score: Int = 0
    var round: Int = 0
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var hitMeBtn: UIButton!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    @IBOutlet var currentLabel: UILabel!
    
    @IBAction func startOver() {
        startNewGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame()
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 50 -  difference
        score += points
        
        var title: String = ""
        if difference == 0 {
            title = "Perfect"
            points += 50
        } else if difference < 5 {
            title = "You were almost there"
            if difference == 1 {
                points += 25
            }
        } else if difference < 10 {
            title = "Pretty good"
        } else {
            title = "Not even close..."
        }
        
        let alert = UIAlertController(title: title,
                                      message: "You hit number \(targetValue) and get \(points) points",
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default) {_ in
                                    self.startNewRound()
        }
        
        let action1 = UIAlertAction(title: "Cancel",
                                    style: .cancel)
        alert.addAction(action)
        alert.addAction(action1)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lround(Double(slider.value))
        print("The current value of slider is \(String(describing: currentValue))")
    }

    func startNewRound() {
        updateLabels()
        round += 1
        updateLabels()
        targetValue = Int.random(in: 1...50)
        currentValue = 50
        slider.value = Float(targetValue)
        targetLabel.text = String(targetValue)
        currentLabel.text = String(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        
    }

    func startNewGame() {
        
        score = 0
        round = 0
        targetValue = 0
        updateLabels()

        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(
        name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
}

