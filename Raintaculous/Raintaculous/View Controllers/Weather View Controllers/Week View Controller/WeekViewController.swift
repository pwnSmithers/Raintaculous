//
//  WeekViewController.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import UIKit

final class WeekViewController: UIViewController {
    var viewModel: WeekViewModel? {
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }
    //MARK:- view life cyle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        
    }

    private func setupViewModel(with viewModel: WeekViewModel){
        
    }
}
