//
//  ViewController.swift
//  Demo
//
//  Created by Amr Guzlan on 2016-06-26.
//  Fork modified by Doron Katz on 2017-03-03
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
        }catch BackgroundVideoErrors.invalidVideo(message: "Video is invalid"){
            print("Video is invalid")
        }catch BackgroundVideoErrors.missingVideo(message: "View is missing"){
            print("Video is missing")
        }catch{
            print("Unknown error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

