//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Jake Sager on 12/3/16.
//  Copyright © 2016 Jake Sager. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAdventure" {
            if let pageController = segue.destination as? PageController {
                pageController.page = Adventure.story
            }
        }
    }


}

