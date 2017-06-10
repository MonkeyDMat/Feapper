//
//  ViewController.swift
//  FeapperDemo
//
//  Created by mathieu lecoupeur on 10/06/2017.
//  Copyright © 2017 mathieu lecoupeur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let feature = "Feature"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Feapper.shared.register(delegate: self, featureId: feature)
    }
    
    @IBAction func onFeatureOn() {
        
        Feapper.shared.flipOn(featureId: feature)
    }
    
    @IBAction func onFeatureOff() {
        
        Feapper.shared.flipOff(featureId: feature)
    }
}

extension ViewController: FeapperDelegate {
    
    func featureEnabled(featureId: String) {
        
        print("Show feature \(featureId)")
    }
    
    func featureDisabled(featureId: String) {
        
        print("Hide feature \(featureId)")
    }
}
