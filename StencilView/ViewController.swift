//
//  ViewController.swift
//  StencilView
//
//  Created by Swarup on 28/6/16.
//  Copyright © 2016 swarup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textView: StencilView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime , dispatch_get_main_queue(), {
            self.textView.drawText("Hello")
        })
        
    }
}

