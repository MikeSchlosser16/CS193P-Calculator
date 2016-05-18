//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mike on 5/18/16.
//  Copyright © 2016 MichaelSchlosser. All rights reserved.
//

import Foundation


class CalculatorBrain{
    private var accumulator = 0.0
    func setOperand(operand: Double){
        accumulator = operand
    }
    func performOperation(symbol: String){
        //Look up the symbol in our dictionary, then use it
        if let operation = operations[symbol]{
            switch operation{
                //Doing operation.Constant but Swift infers it. Then we are getting value from that case. Value and fucntion just local variables
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
                //Creating struct, using the "free initalizer", putting function/operand in the struct
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = pendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil{
            //Struct is pendingBinaryInfo, which pending was declared as below. Because of this, we can use the binary function attribute of the struct and pass it paramters, two doubles
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    
    //Of type struct below, making optional because pendingBinaryOperationInfo only there if we have a pending operation. Otherwise nil until then, so optional
    private var pending: pendingBinaryOperationInfo?
    
    
    //Struct much like class, but struct are passed by value and classes are passed by reference.
    //When passed, Swift doesnt actually make a copy until you touch it for efficency.
    private struct pendingBinaryOperationInfo {
        //Binary function that im going to do, takes 2 doubles and returns a double
        //Variable is of type function..
        var binaryFunction: (Double,Double)->Double
        var firstOperand: Double
    }
    
    //Dictonary to get operation, better code
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        //Using closure with default arguments. We are taking advatage of type inference here
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
    ]
    
    //Since we need operations dictionary to work for double and functions, we can use enum
    enum Operation{
        case Constant(Double)
        /*In swift no difference between fucntion and double, both types.
        Takes a double and returns a double in case of unary operation. */
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double, Double)->Double)
        case Equals
    }
    
    
    /*Overview: Executing assocaited value, looked up sqrt, found tat it was a unary operation,
    with associated value sqrt, went to perform operation, found .UnaryOperation, got function
    of that assocaited value, and then used it to update accumulator.*/
    
    
    
    
    //Computed read only result
    var result: Double{
        get{
            return accumulator
        }
    }
}