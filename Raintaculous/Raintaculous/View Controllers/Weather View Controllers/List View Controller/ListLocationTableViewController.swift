//
//  ListLocationTableViewController.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import UIKit

class ListLocationTableViewController: UITableViewController {
    
    //MARK:- Properties
    private var locations = [Location]()
    
    var viewModel: ListViewModel? {
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }
    
    //MARK:- Outlets
    
    @IBOutlet weak var helpButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let listViewModel = ListViewModel()
        self.viewModel = listViewModel
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.handleCoreData()
    }

    //MARK:- private methods
    private func setupView() {
        
        self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItems = [helpButton,self.editButtonItem]
    }
    
    
    private func setupViewModel(with viewModel: ListViewModel) {
        viewModel.handleCoreData()
        tableView.reloadData()
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
        return viewModel?.locations.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListLocationTableViewCell.reuseidentifier, for: indexPath) as? ListLocationTableViewCell else {
            fatalError("Unable to dequeue week day table view cell")
        }
        
        let cellVM = ListCellViewModel(location: LocationM(latitude: Double(viewModel?.locations[indexPath.row].latitude ?? "") ?? 0, longitude: Double(viewModel?.locations[indexPath.row].longitude ?? "") ?? 0))
        cell.viewModel = cellVM
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView"{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                
                let mainVC = segue.destination as! MainViewController
                let selectedLocation = LocationM(latitude: Double(viewModel?.locations[indexPath.row].latitude ?? "") ?? -122.008928, longitude: Double(viewModel?.locations[indexPath.row].longitude ?? "") ?? -122.008928)
                let mainViewModel = MainViewModel(locationService: LocationManager(), location: selectedLocation)
                mainVC.viewModel = mainViewModel
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            viewModel?.deleteLocation(of: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
