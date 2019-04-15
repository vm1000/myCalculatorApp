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

    var player: AVAudioPlayer = AVAudioPlayer()
    
    @IBAction func Play(_ sender: Any){
        player.play()
    }
    
    @IBOutlet var buttons: [UIButton]!

    enum Operand: Int {
        case add = 10
        case subtract = 11
        case multiply = 12
        case divide = 13
    }
    var theNumber = ""
//    let plus = 10
//    let minus = 11
//    let multiply = 12
//    let divide = 13
    
    @IBAction func buttonPressed(sender: UIButton){
    theNumber += "\(sender.tag)"
    lblText.text = theNumber
    }
    
    @IBOutlet var lblText : UILabel!
    
    var num1 = 0.0
    var num2 = 0.0
    var operand = 0
    var answer = 0.0
 
    @IBAction func calculate(sender : UIButton) {
        num2 = Double(Int(theNumber)!)
        
        switch operand {
        case Operand.add.rawValue:
            answer = num1 + num2
        case Operand.subtract.rawValue:
            answer = num1 - num2
        case Operand.multiply.rawValue:
            answer = num1 * num2
        default:
            answer = num1 / num2
        }
//        if operand == plus {
//            answer = Double(num1 + num2)
//        }
//        if operand == minus {
//            answer = Double(num1 - num2)
//        }
//        if operand == multiply {
//            answer = Double(num1 * num2)
//        }
//        if operand == divide {
//
//            if num2 == 0 {
//                let alert = UIAlertController(title: "Error", message: "Cant divide by zero", preferredStyle: .alert)
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                alert.addAction(cancelAction)
//                present(alert, animated: true)
//            } else {
//            answer = Double(num1) / Double(num2)
//        }
//    }
       clear()
    }
    
    func clear(){
        num1 = 0.0
        num2 = answer
        operand = Operand.add.rawValue
        theNumber = String(answer)
        printNumber()
        answer = num2
        theNumber = ""
    }
    
    @IBAction func setOperand(sender : UIButton) {
        if theNumber != "" {
            operand = sender.tag
            saveNum1()
            theNumber = ""
        }
    }
    
    @IBAction func clearOperation(_ sender: UIButton) {
        theNumber = "0"
        printNumber()
    }

    func saveNum1() {
        num1 = Double(Int(theNumber)!)
        theNumber = String(num1)
        printNumber()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            let audioPlayer = Bundle.main.path(forResource: "tap", ofType: "wav")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPlayer!) as URL)
                }
        catch{
            //ERROR
        }
        
        for i in buttons {
            i.imageView?.contentMode = .scaleAspectFit
        }
        theNumber = ""
        printNumber()
    }
    
    func printNumber() {
        let newNumber = theNumber.replacingOccurrences(of: ".0", with: "")
//        let formatter = NumberFormatter()
//        formatter.minimumIntegerDigits = 1
//        formatter.minimumFractionDigits = 0
//        formatter.maximumFractionDigits = 15
//        let newNumber = formatter.string(for: theNumber)
        lblText.text = newNumber
    }
    
    @IBAction func pressNum(sender : UIButton) {
//            theNumber = ""
//            theNumber += String(sender.tag)
            printNumber()
    }
}

