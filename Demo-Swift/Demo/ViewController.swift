//
//  ViewController.swift
//  Demo
//
//  Created by Amr Guzlan on 2016-06-26.
//  Copyright © 2016 Amro Gazlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var backgroundPlayer : BackgroundVideo? // Declare an instance of BackgroundVideo called backgroundPlayer

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initializing your instance
        backgroundPlayer = BackgroundVideo(onViewController: self, withVideoURL: "test.mp4") // Passing self and video name with extension
        backgroundPlayer?.setUpBackground()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

