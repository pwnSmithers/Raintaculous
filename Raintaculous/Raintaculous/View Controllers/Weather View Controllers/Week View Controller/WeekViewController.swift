//
//  WeekViewController.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import UIKit

final class WeekViewController: UIViewController {
    //MARK:- Properties
    var viewModel: WeekViewModel? {
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }
    
    @IBOutlet var tableView: UITableView! {
        didSet{
            tableView.isHidden = true
            tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.rowHeight = UITableView.automaticDimension
            tableView.showsVerticalScrollIndicator = false
        }
    }
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!{
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    //MARK:- view life cyle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupViewModel(with viewModel: WeekViewModel){
        activityIndicatorView.stopAnimating()
        
        tableView.reloadData()
        tableView.isHidden = false
    }
}

extension WeekViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekDayTableViewCell.reuseidentifier, for: indexPath) as? WeekDayTableViewCell else {
            fatalError("Unable to dequeue week day table view cell")
        }
        
        guard let viewModel = viewModel else {
            fatalError("No view model present")
        }
        
        cell.configure(with: viewModel.viewModel(for: indexPath.row))
        return cell
    }
    
    
}
