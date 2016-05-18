//
//  ViewController.swift
//  Calculator
//
//  Created by Mike on 5/16/16.
//  Copyright © 2016 MichaelSchlosser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Do outlet so we get proprty not method
    @IBOutlet private weak var display: UILabel!
    private var userInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        //Optional, type of set of not set, so unwrap it. Pretty cool
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text! = textCurrentlyInDisplay + digit
        }
        else{
            //Get rid of the 0, set it to just 0.
            display.text = digit
        }
       userInTheMiddleOfTyping = true
    }
    
    //Computed property
    private var displayValue: Double{
        set{
            display.text = String(newValue)
        }
        get{
            return Double(display.text!)!
        }
    }
    
    //Creating brain to communicate with Model of MVC, get 1 free initializer.
    private var brain = CalculatorBrain()
    @IBAction private func performOperation(sender: UIButton){
        //Start again with just digit displayed after we hit math operation
        if userInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userInTheMiddleOfTyping = false
        }
        
        //If can let mathematical symbol = current title, unwrap. No need for ! now
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        
        
    }
    
}