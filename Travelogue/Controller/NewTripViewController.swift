//
//  NewTripViewController.swift
//  Travelogue
//
//  Created by Kartik Sharma on 12/02/19.
//  Copyright © 2019 Kartik Sharma. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    var exisitingTrip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = exisitingTrip?.title
    }
    
    @IBAction func saveTrip(_ sender: Any) {
        let tripName = titleTextField.text ?? "".trimmingCharacters(in: .whitespaces)
        if (tripName == "") {
            alertNotifyUser(message: "Fields required")
            return
        }
        
        var trip: Trip?
        
        if let exisitingTrip = exisitingTrip {
            exisitingTrip.title = tripName
            trip = exisitingTrip
        } else {
            trip = Trip(title: tripName)
        }
        
        if let trip = trip {
            do {
                try trip.managedObjectContext?.save()
                self.navigationController?.popViewController(animated: true)
            }
            catch {
                print("Unable to save.")
            }
        }
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
