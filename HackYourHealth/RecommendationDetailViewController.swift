//
//  RecommendationDetailViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit
class RecommendationDetailViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var text: String!
    override func viewDidLoad() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        label.text = text
    }
}
