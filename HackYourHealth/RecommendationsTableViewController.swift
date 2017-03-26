//
//  RecommendationsTableViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class RecommendationsTableViewController: UITableViewController {

    var current: Double = 0
        {
        didSet
        {
            recomendations = HealthRecommendation.recommended(for: current)
        }
    }
    private var recomendations = [HealthRecommendation]()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recomendations.count
    }


    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")

        cell.textLabel?.text = "\(recomendations[indexPath.row])"

        return cell
    }

    
    
}
