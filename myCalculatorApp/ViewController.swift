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
    

    
    let plus = 10
    let minus = 11
    let multiply = 12
    let divide = 13
    
    
    
    @IBOutlet var lblText : UILabel!
    
    
    var num1 : Int = 0
    var num2 : Int = 0
    var operand : Int = 0
    var answer : Double = 0.0
    
    
    var theNumber : String = "0"
    
    
    @IBAction func calculate(sender : UIButton){
        num2 = Int(theNumber)!
        
        if operand == plus{
            answer = Double(num1 + num2)
        }
        if operand == minus {
            answer = Double(num1 - num2)
        }
        if operand == multiply {
            answer = Double(num1 * num2)
        }
        if operand == divide {
            
            if num2 == 0 {
                let alert = UIAlertController(title: "Error", message: "Cant divide by zero", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alert.addAction(cancelAction)
                
                present(alert, animated: true)
                
            } else{
            answer = Double(num1) / Double(num2)
        }
    }
        
        num1 = 0
        num2 = 0
        operand = plus
        theNumber = String(answer)
        
        
        
        printNumber()
        
        answer = 0.0
        theNumber = "0"
    }
    
    
    @IBAction func setOperand(sender : UIButton){
            operand = sender.tag
            saveNum1()
    }
    
    
    @IBAction func clearOperation(_ sender: UIButton) {
        theNumber = "0"
        printNumber()
    }

    
    
    func saveNum1(){
        num1 = Int(theNumber)!
        theNumber = "0"
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
        
        printNumber()
    }
    
    
    
    func printNumber(){
        
        let newNumber = theNumber.replacingOccurrences(of: ".0", with: " ")
        lblText.text = newNumber
        

    }
    
    
    
    @IBAction func pressNum(sender : UIButton) {
        
            theNumber = ""
            theNumber += String(sender.tag)
            printNumber()
    }

}

