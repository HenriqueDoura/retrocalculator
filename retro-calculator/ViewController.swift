//
//  ViewController.swift
//  retro-calculator
//
//  Created by Mark Price on 8/1/15.
//  Copyright © 2015 devslopes. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
         try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
      
    }
    
    //Actions
    @IBAction func onClearPressed(sender: AnyObject) {
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        outputLbl.text = "0"
    }
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
         processOperation(Operation.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
         processOperation(Operation.Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
         processOperation(Operation.Divide)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
         processOperation(currentOperation)
        
    }
    
    //Other funcs
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run some math
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

