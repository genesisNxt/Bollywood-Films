//
//  ViewController.swift
//  Bollywood Films
//
//  Created by PARMJIT SINGH KHATTRA on 21/6/20.
//  Copyright © 2020 PARMJIT SINGH KHATTRA. All rights reserved.
//

import UIKit
import CoreData
class FilmViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let constant = Constant()
    var films = [Film]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadFilms()
    }
// MARK:- Add Methods and  save Functions
    @IBAction func addFilms(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Films", message: "Bollywood Films", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let newFilms = Film(context: self.context)
            newFilms.name = textField.text
            self.films.append(newFilms)
            self.saveFilms()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "new film"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    func saveFilms() {
        do {
            try context.save()
        } catch  {
            print("Error Saving\(error)")
        }
        tableView.reloadData()
    }
// MARK:- Load Functions
func loadFilms(){
    let request: NSFetchRequest<Film> = Film.fetchRequest()
    do {
       films = try context.fetch(request)
    } catch  {
        print("Error Loading\(error)")
    }
}
    
}
    // MARK:- TableView DataSource
extension FilmViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constant.filmCell, for: indexPath)
        cell.textLabel?.text = films[indexPath.row].name
        return cell
    }
}
    // MARK:- TableView Delegate
extension FilmViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: constant.goToActor, sender: self)
    }
}

