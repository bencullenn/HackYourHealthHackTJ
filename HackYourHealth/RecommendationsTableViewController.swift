//
//  RecommendationsTableViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class RecommendationsTableViewController: UITableViewController {
    
    private var recommendations = [HealthRecommendation]()
    override func viewDidLoad() {
        recommendations = HealthRecommendation.recommended()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")

        cell.textLabel?.text = recommendations[indexPath.row].title
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showReco", sender: recommendations[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReco", let viewController = segue.destination as? RecommendationDetailViewController, let recommendation = sender as? HealthRecommendation{
            viewController.text = recommendation.summary
        }
    }
}
