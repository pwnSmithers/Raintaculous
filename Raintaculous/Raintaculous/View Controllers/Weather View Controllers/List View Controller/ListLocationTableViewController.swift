//
//  ListLocationTableViewController.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import UIKit

class ListLocationTableViewController: UITableViewController {
    
    //MARK:- Outlets

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
   
    }

    //MARK:- private methods
    private func setupView() {
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.rightBarButtonItem = self.editButtonItem
       
    }
    
    private let mapViewController: MapViewController = {
        if #available(iOS 13.0, *) {
            guard let mapVC =  UIStoryboard.main.instantiateViewController(identifier: MapViewController.storyboardIdentifier) as? MapViewController else{
                fatalError("Unable to instiate Map View Controller")
            }
            mapVC.view.translatesAutoresizingMaskIntoConstraints = false
            return mapVC
        } else {
            // Fallback on earlier versions
            guard let mapVC = UIStoryboard.main.instantiateViewController(withIdentifier: MapViewController.storyboardIdentifier) as? MapViewController else {
                fatalError("Unable to instiate Map View Controller")
            }
            mapVC.view.translatesAutoresizingMaskIntoConstraints = false
            return mapVC
        }
    }()

}

extension ListLocationTableViewController{
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListLocationTableViewCell.reuseidentifier, for: indexPath) as? ListLocationTableViewCell else {
            fatalError("Unable to dequeue week day table view cell")
        }
        
        return cell
    }
}
