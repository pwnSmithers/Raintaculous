//
//  ListCellViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import UIKit

protocol CurrentCityName {
    var name: String {get}
}

class ListViewModel: NSObject {

    var locations = [Location]()
    
    
    //MARK:- private methods
    func handleCoreData() {
        if #available(iOS 10.0, *){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            do {
                locations = try context.fetch(Location.fetchRequest())
//                self.tableView.reloadData()
            }catch  let error as NSError {
                print("Couln't fetch \(error), \(error.userInfo)")
            }
        } else {
            
        }
    }

}
