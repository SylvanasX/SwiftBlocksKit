//
//  ViewController.swift
//  SwiftBlocksKit
//
//  Created by SylvanasX on 09/24/2017.
//  Copyright (c) 2017 SylvanasX. All rights reserved.
//

import UIKit
import SwiftBlocksKit

class ViewController: UIViewController {
    
    @IBOutlet var testView: UIView!
    @IBOutlet weak var btn: UIButton!
    
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sw = UISwitch()
        
  
        
        btn.sb.addEventHandlerForControlEvents(.touchUpInside) { (btn) in
            print(btn)
        }
        
//        timer = Timer.sb.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
//            print(timer)
//        })
//        testView.isUserInteractionEnabled = true
        testView.sb.whenTappd {
            print("tapped")
        }
        
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

