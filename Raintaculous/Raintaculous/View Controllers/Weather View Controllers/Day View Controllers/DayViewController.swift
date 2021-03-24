//
//  DayViewController.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import UIKit

final class DayViewController: UIViewController {

    var viewModel: DayViewModel? {
        didSet{
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .green
    }
    
    private func setupViewModel(with viewModel: DayViewModel){
        
    }

}
