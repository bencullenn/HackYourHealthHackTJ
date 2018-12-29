//
//  RecommendationsTableViewController.swift
//  HackYourHealth
//
//  Created by Ben Cullen on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import UIKit

class RecommendationsTableViewController: UITableViewController {

    private var recommendations = [HealthRecommendation]() {
        didSet {
            if recommendations.isEmpty {
                tableView.separatorStyle = .none
                tableView.allowsSelection = false
                tableView.isScrollEnabled = false
            } else {
                tableView.separatorStyle = .singleLine
                tableView.allowsSelection = true
                tableView.isScrollEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        tableView.tableFooterView = UIView()
        recommendations = HealthRecommendation.recommended()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(recommendations.count, 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = recommendations.isEmpty
            ? "You are very healthy. Good Job!"
            : recommendations[indexPath.row].title
        return cell
    }

    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if recommendations.isEmpty { return }
        performSegue(withIdentifier: "showReco", sender: recommendations[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReco",
            let viewController = segue.destination as? RecommendationDetailViewController,
            let recommendation = sender as? HealthRecommendation {
            viewController.title = recommendation.title
            viewController.text = recommendation.summary
        }
    }
}
