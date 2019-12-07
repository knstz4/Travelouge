//
//  ViewController.swift
//  Travelogue
//
//  Created by Kartik Sharma on 12/02/19.
//  Copyright © 2019 Kartik Sharma. All rights reserved.
//

import UIKit
import CoreData

class TripViewController: UIViewController {

    @IBOutlet weak var tripsTableView: UITableView!
    
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
            trips = try managedContext.fetch(fetchRequest)
            tripsTableView.reloadData()
        }
        catch {
            print("Can't fetch trips.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEntries" {
            guard let destination = segue.destination as? EntryViewController,
                let selectedRow = self.tripsTableView.indexPathForSelectedRow?.row else {
                    return
            }
            
            destination.trip = trips[selectedRow]
            
        }
        if segue.identifier == "showTrip" {
            
            guard let indexPath = sender as? NSIndexPath else {
                return
            }
            
            if let controller = segue.destination as? NewTripViewController {
                controller.exisitingTrip = trips[indexPath.row]
            }
        }
    }
    
    func deleteCategory(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        guard let managedContext = trip.managedObjectContext else {
            return
        }
        
        managedContext.delete(trip)
        do {
            try managedContext.save()
            trips.remove(at: indexPath.row)
            tripsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        catch {
            print("Unable to delete category")
            tripsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

}

extension TripViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        let trip = trips[indexPath.row]
        
        cell.textLabel?.text = trip.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath)  in
            self.performSegue(withIdentifier: "showTrip", sender: indexPath)
        })
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            self.handleDelete(at: indexPath)
        })
        
        return [deleteAction, editAction]
    }
    
    func handleDelete(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        let dialogMessage = UIAlertController(title: "Confirm Delete", message: "Are you sure you would like to delete?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in
            self.deleteCategory(at: indexPath)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancelled")
        }
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user if there is entriess
        if trip.entries?.count ?? 0 > 0 {
            self.present(dialogMessage, animated: true, completion: nil)
        } else {
            deleteCategory(at: indexPath)
        }
    }
}

