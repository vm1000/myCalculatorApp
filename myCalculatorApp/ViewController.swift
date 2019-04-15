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
        player?.play()
    }
    
    @IBAction func pressNum(sender: UIButton) {
        if answer == "0" {
            answer = String(sender.tag)
        } else {
            answer += String(sender.tag)
        }
        
        printNumber()
    }
    
    @IBAction func calculate() {
        switch operand {
        case .add:
            answer = String(num1 + num2)
        case .divide:
            answer = String(num1 - num2)
        case .multiply:
            answer = String(num1 * num2)
        case .subtract:
            if num2 == 0 {
                answer = "Divided by 0"
            } else {
                answer = String(num1 / num2)
            }
        }
    }
    
    @IBAction func setOperand(sender: UIButton) {
        operand = Operand(rawValue: sender.tag) ?? .add
        saveNum1()
        
    }
    
    @IBAction func clearOperation() {
        num1 = 0
        num2 = 0
        answer = "0"
        
        printNumber()
    }
    
    enum Operand: Int {
        case add = 10
        case subtract = 11
        case multiply = 12
        case divide = 13
    }
    
    var player: AVAudioPlayer?
    
    var num1 = 0.0 {
        didSet {
            print("Did save number 1: \(num1)")
        }
    }
    var num2 = 0.0 {
        didSet {
            print("Did save number 2: \(num2)")
        }
    }
    var operand: Operand = .add
    var answer = "0" {
        didSet {
            print("Current answer: \(answer)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let resourcePath = Bundle.main.path(forResource: "tap", ofType: "wav") {
            player = try? AVAudioPlayer.init(contentsOf: URL(fileURLWithPath: resourcePath))
        }
        
        for button in buttons {
            button.imageView?.contentMode = .scaleAspectFit
        }
        
        printNumber()
    }
    
    func saveNum1() {
        if let number = Double(answer) {
            num1 = number
        }
        
        printNumber()
    }
    
    func saveNum2() {
        if let number = Double(answer) {
            num2 = number
        }
        
        calculate()
    }
    
    func printNumber() {
        label.text = answer.replacingOccurrences(of: ".0", with: "")
    }
}

