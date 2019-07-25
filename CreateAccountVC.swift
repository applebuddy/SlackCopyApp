//
//  CreateAccountVC.swift
//  SmackPractice
//
//  Created by Min Kyeong Tae on 20/07/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
}
