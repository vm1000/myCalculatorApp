//
//  ViewController.swift
//  myCalculatorApp
//
//  Created by egmars.janis.timma on 11/04/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func play(_ sender: Any) {
        audioPlayer?.play()
    }
    
    @IBAction func selectedNumber(_ sender: UIButton) {
        if label.text == "0" {
            runningNumber = String(sender.tag)
        } else {
            runningNumber += String(sender.tag)
        }

        label.text = runningNumber
    }
    
    @IBAction func equals() {
        let rightValue = Double(runningNumber)

        if let lhs = leftValue, let rhs = rightValue {
            var result = ""

            switch operand {
            case .add:
                result = String(lhs + rhs)
            case .subtract:
                result = String(lhs - rhs)
            case .multiply:
                result = String(lhs * rhs)
            case .divide:
                if rhs != 0 {
                    result = String(lhs / rhs)
                }
            }

            let formatter = NumberFormatter()
            formatter.minimumIntegerDigits = 1
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 5

            label.text = formatter.string(for: Double(result))
            leftValue = Double(result)
            runningNumber = ""
        }
    }
    
    @IBAction func setOperand(_ sender: UIButton) {
        if leftValue == nil {
            leftValue = Double(runningNumber)
            runningNumber = ""
        } else {
            equals()
        }

        operand = Operand(rawValue: sender.tag)!
    }
    
    @IBAction func clear() {
        leftValue = nil
        runningNumber = ""
        
        label.text = "0"
    }
    
    enum Operand: Int {
        case add = 10
        case subtract = 11
        case multiply = 12
        case divide = 13
    }
    
    var audioPlayer: AVAudioPlayer? {
        didSet {
            audioPlayer?.prepareToPlay()
        }
    }
    
    var leftValue: Double? = nil
    var runningNumber = ""
    var operand: Operand = .add

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let resourcePath = Bundle.main.path(forResource: "tap", ofType: "wav") {
            try? audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: resourcePath))
        }
        
        for button in buttons {
            button.imageView?.contentMode = .scaleAspectFit
        }
    }
}
