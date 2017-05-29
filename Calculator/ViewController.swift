//
//  ViewController.swift
//  Calculator
//
//  Created by Wang Shilong on 5/22/17.
//  Copyright © 2017 Will Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userJustStartTyping = true
    
    var decimalUsed = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userJustStartTyping {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            userJustStartTyping = false
            
        } else {
            let textCurrentlyInDisplay = display.text!
            if digit != "." || textCurrentlyInDisplay.range(of: ".") == nil {
                display.text = textCurrentlyInDisplay + digit
            }
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func backSpace(_ sender: UIButton) {
        if userJustStartTyping {
            return
        } else {
            if var number = display.text {
                number.remove(at: number.characters.index(before: number.endIndex))
                if number.isEmpty {
                    number = "0"
                    userJustStartTyping = true
                }
                display.text = number
                
            }
        }
    }
    @IBAction func performOperation(_ sender: UIButton) {
        
        if !userJustStartTyping {
            brain.setOperand(displayValue)
            userJustStartTyping = true
        }
        
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
        
        
    }
    
    
    
}

