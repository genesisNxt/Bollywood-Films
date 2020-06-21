//
//  ActorTableViewController.swift
//  Bollywood Films
//
//  Created by PARMJIT SINGH KHATTRA on 21/6/20.
//  Copyright © 2020 PARMJIT SINGH KHATTRA. All rights reserved.
//

import UIKit
import CoreData
class ActorTableViewController: UITableViewController {

    var actor = [Actor]()
    let constant = Constant()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedFilm: Film? {
        didSet {
            loadActor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadActor()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actor.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constant.actorCell, for: indexPath)
        cell.textLabel?.text = actor[indexPath.row].name
        return cell
    }
    // MARK:- add save Functions and methods
    
    @IBAction func addActor(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Actor Name", message: "Bollywood Actor", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
            let newActor = Actor(context: self.context)
            newActor.name = textField.text
            newActor.done = false
            newActor.parentFilm = self.selectedFilm
            self.actor.append(newActor)
            self.saveActor()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "new actor"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
        func saveActor(){
        do {
            try context.save()
        } catch  {
            print("Error saving\(error)")
        }
        tableView.reloadData()
}
    // MARK:- add load Functions
    func loadActor(with request: NSFetchRequest<Actor> = Actor.fetchRequest()){
                //let request: NSFetchRequest<Actor> = Actor.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentFilm.name MATCHES %@", selectedFilm!.name!)
        request.predicate = categoryPredicate
        
                do {
                   actor = try context.fetch(request)
                } catch  {
                    print("Error Loading\(error)")
                }
                
            }
}

