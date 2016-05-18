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
    @IBOutlet weak var display: UILabel!
    var userInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(sender: UIButton) {
        //Optional, type of set of not set, so unwrap it. Pretty cool
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text! = textCurrentlyInDisplay + digit
        }
        else{
            //Get rid of the 0, set it to just 0.
            display.text! = digit
        }
       userInTheMiddleOfTyping = true
    }
    
    @IBAction func performOperation(sender: UIButton){
        //Start again with just digit displayed after we hit math operation
        userInTheMiddleOfTyping = false
        //If can let mathematical symbol = current title, unwrap. No need for ! now
        if let mathematicalSymbol = sender.currentTitle{
            if mathematicalSymbol == "π"{
                display.text = String(M_PI)
            }
        }
        
        
    }
    
}