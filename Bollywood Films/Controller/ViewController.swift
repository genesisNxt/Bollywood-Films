//
//  ViewController.swift
//  Bollywood Films
//
//  Created by PARMJIT SINGH KHATTRA on 21/6/20.
//  Copyright © 2020 PARMJIT SINGH KHATTRA. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let constant = Constant()
    var films = [Film]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
// MARK:- Add Methods and  save Functions
    @IBAction func addFilms(_ sender: UIBarButtonItem) {
        
        
    }
    
    
// MARK:- Load Functions
    
    // MARK:- TableView DataSource
    extension
    // MARK:- TableView Delegate
}

