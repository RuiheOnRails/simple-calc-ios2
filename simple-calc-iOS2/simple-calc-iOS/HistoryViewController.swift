//
//  HistoryViewController.swift
//  simple-calc-iOS
//
//  Created by Jerry Li on 1/30/18.
//  Copyright © 2018 Jerry Li. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController : UIViewController{
    
    var history: [String] = []
    
    @IBOutlet weak var scrollPane: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayHistory()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearHistoryPressed(_ sender: Any) {
        history = []
        displayHistory()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        destination.history = history
    }
    
    func displayHistory(){
        if history.count != 0 {
            for index in 0...history.count-1{
                let label = UILabel(frame:CGRect(x: 50, y: index*25+50, width: 300, height: 40))
                label.text = history[index]
                scrollPane.addSubview(label)
            }
        }else{
            scrollPane.subviews.forEach({$0.removeFromSuperview()})
        }
    }
}
