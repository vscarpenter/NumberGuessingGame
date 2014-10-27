//
//  ViewController.swift
//  NumberGuessingGame
//
//  Created by Vinny Carpenter on 10/26/14.
//  Copyright (c) 2014 Vinny Carpenter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var number: Int!
    var numberOfGuess: Int = 0
    var timer = NSTimer()
    var numberOfSeconds: Int = 0
    var startTime = NSTimeInterval()
    var timerStarted: Bool = false
    @IBOutlet var guessTextField: UITextField!
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var noOfAttemptsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        number = Int(arc4random_uniform(100)) + 1 //add 1 to make it from 0-99 to 0-100
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func guessButtonPressed(sender: AnyObject) {
        println("button pressed")
        
        if (timerStarted == false) {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            timerStarted = true
        }
        var guessNumber = guessTextField.text.toInt()
        numberOfGuess++
        if (guessNumber > number) {
            answerLabel.text = "Sorry - your guess is too high. Try again!"
        } else if (guessNumber < number) {
            answerLabel.text = "Sorry - your guess is too low. Try again!"
        } else if (guessNumber == number) {
            answerLabel.text = "Great guess.  You Win!!"
            timer.invalidate()
        }
        noOfAttemptsLabel.text = "# of attempts: \(numberOfGuess)"
    }
    
    @IBAction func resetButtonPressed(sender: AnyObject) {
        timer.invalidate()
        noOfAttemptsLabel.text = "# of attempts"
        timerLabel.text = "00:00:00"
        answerLabel.text = "New game started!"
        guessTextField.text = ""
        numberOfGuess = 0
        timerStarted = false
        number = Int(arc4random_uniform(100)) + 1 //re-generate random number
    }
    
    func update() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        timerLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
}

