//
//  ViewController.swift
//  simple-calc-iOS
//
//  Created by Jerry Li on 1/27/18.
//  Copyright © 2018 Jerry Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ioTextField: UITextField!
    
    var history: [String] = []
    var combinedDisplay : String = "" {
        didSet{
            ioTextField.text = combinedDisplay
        }
    }
    var numberBuilder : String = ""
    var numbers: [Double] = []
    var op: String = ""
    var decimalMode: Bool = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedOne(_ sender: UIButton) {
        appender("1")
    }
    
    @IBAction func pressedTwo(_ sender: UIButton) {
        appender("2")
    }
    
    @IBAction func pressedThree(_ sender: UIButton) {
        appender("3")
    }
    
    @IBAction func pressedFour(_ sender: UIButton) {
        appender("4")
    }
    
    @IBAction func pressedFive(_ sender: UIButton) {
        appender("5")
    }
    
    @IBAction func pressedSix(_ sender: UIButton) {
        appender("6")
    }
    
    @IBAction func pressedSeven(_ sender: UIButton) {
        appender("7")
    }
    
    @IBAction func pressedEight(_ sender: UIButton) {
        appender("8")
    }
 
    @IBAction func pressedNine(_ sender: UIButton) {
        appender("9")
    }
    
    @IBAction func pressedZero(_ sender: UIButton) {
        appender("0")
    }
    
    @IBAction func pressedDot(_ sender: UIButton) {
        if(decimalMode == false){
            if(numberBuilder == "" ){
                appender("0")
            }
            decimalMode = true
            appender(".")
        }
    }
    
    @IBAction func handleAdd(_ sender: UIButton) {
        if(op == "" && !numberBuilder.isEmpty){
            numComplete()
            combinedDisplay.append(" + ")
            op = "+"
        }
    }
    
    @IBAction func handleSub(_ sender: UIButton) {
        if(op == "" && !numberBuilder.isEmpty){
            numComplete()
            combinedDisplay.append(" - ")
            op = "-"
        }
    }
    
    @IBAction func handleTimes(_ sender: UIButton) {
        if(op == "" && !numberBuilder.isEmpty){
            numComplete()
            combinedDisplay.append(" * ")
            op = "*"
        }
    }
    
    @IBAction func handleDivide(_ sender: UIButton) {
        if(op == "" && !numberBuilder.isEmpty){
            numComplete()
            combinedDisplay.append(" / ")
            op = "/"
        }
    }
    
    @IBAction func handleMod(_ sender: UIButton) {
        if(op == "" && !numberBuilder.isEmpty){
            numComplete()
            combinedDisplay.append(" % ")
            op = "%"
        }
    }
    
    
    @IBAction func handleCount(_ sender: UIButton) {
        if((op == "" || op == "count") && !numberBuilder.isEmpty){
            numComplete()
            combinedDisplay.append(" count ")
            op = "count"
        }
    }
    
    @IBAction func handleAvg(_ sender: UIButton) {
        if((op == "" || op == "avg") && !numberBuilder.isEmpty){
            numComplete()
            combinedDisplay.append(" avg ")
            op = "avg"
        }
    }
    
    @IBAction func handleFact(_ sender: UIButton) {
        if(op == "" && !numberBuilder.isEmpty){
            numComplete()
            combinedDisplay.append(" fact ")
            op = "fact"
        }
    }
    
    @IBAction func handleClear(_ sender: UIButton) {
        reset()
    }
    
    func numComplete (){
        numbers.append(Double(numberBuilder) ?? 0)
        numberBuilder = ""
        decimalMode = false
    }
    
    func appender(_ s: String){
        numberBuilder.append(s)
        combinedDisplay.append(s)
    }
    
    func reset(){
        combinedDisplay = ""
        numberBuilder = ""
        op = ""
        numbers = []
    }
    
    func warningDivModZero(){
        let alert = UIAlertController(title: "Error", message: "Can not divide/mod by zero", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`))
        self.present(alert, animated: true, completion: nil)
        reset()
    }
    
    @IBAction func handleCalc(_ sender: UIButton) {
        if(!numberBuilder.isEmpty){
            numComplete()
        }
        switch op{
        case "+":
            let sum = numbers[0] + numbers[1]
            addToHistory(combinedDisplay + " = " + String(sum))
            combinedDisplay = String(sum)
            numberBuilder = String(sum)
            numbers = []
            op = ""
        case "-":
            let sub = numbers[0] - numbers[1]
            addToHistory(combinedDisplay + " = " + String(sub))
            combinedDisplay = String(sub)
            numberBuilder = String(sub)
            numbers = []
            op = ""
        case "*":
            let times = numbers[0] * numbers[1]
            addToHistory(combinedDisplay + " = " + String(times))
            combinedDisplay = String(times)
            numberBuilder = String(times)
            numbers = []
            op = ""
        case "/":
            if(numbers[1] == 0){
                warningDivModZero()
            }else{
                let divide = numbers[0] / numbers[1]
                addToHistory(combinedDisplay + " = " + String(divide))
                combinedDisplay = String(divide)
                numberBuilder = String(divide)
                numbers = []
                op = ""
            }
        case "%":
            if(numbers[1] == 0){
                warningDivModZero()
            }else{
                let mod = Int(numbers[0]) % Int(numbers[1])
                addToHistory(combinedDisplay + " = " + String(mod))
                combinedDisplay = String(mod)
                numberBuilder = String(mod)
                numbers = []
                op = ""
            }
        case "count":
            let count = numbers.count
            addToHistory(combinedDisplay + " = " + String(count))
            reset()
            combinedDisplay = String(count)
            numberBuilder = String(count)
        case "avg":
            let count: Double = Double(numbers.count)
            var sum: Double = 0.0
            numbers.forEach({ number in
                sum += number
            })
            let avg:Double = sum/count
            addToHistory(combinedDisplay + " = " + String(avg))
            reset()
            combinedDisplay = String(avg)
            numberBuilder = String(avg)
        case "fact":
            if(numbers[0] > 20){
                reset()
            }else{
                var fact = 1
                for i in 1...Int(numbers[0]){
                    fact *= i
                }
                addToHistory(combinedDisplay + " = " + String(fact))
                reset()
                combinedDisplay = String(fact)
                numberBuilder = String(fact)
            }
        default: reset()
        }
    }
    
    func addToHistory(_ toAdd: String){
        history.append(toAdd);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! HistoryViewController
        destination.history = history
    }
}
