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
        do{
            try backgroundPlayer = BackgroundVideo(on: self.view, withVideoURL: "test.mp4") // Passing self and video name with extension
            try backgroundPlayer?.setUpBackground()
            // Do any additional setup after loading the view, typically from a nib.
        }catch{
            print("error/issue with adding video")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

