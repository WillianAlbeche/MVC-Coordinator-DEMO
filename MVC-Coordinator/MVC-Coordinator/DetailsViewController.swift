//
//  DetailsViewController.swift
//  MVC-Coordinator
//
//  Created by Willian Magnum Albeche on 04/03/22.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    private  func loadTableView() {
        let nibTitle = UINib(nibName:"TableViewCellTitleDetails", bundle: nil)
        let nibDescription = UINib(nibName: "TableViewCellDescriptionDetails", bundle: nil)
        tableView.register(nibTitle, forCellReuseIdentifier: TableViewCellTitleDetails.id)
        tableView.register(nibDescription, forCellReuseIdentifier: TableViewCellDescriptionDetails.id)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellTitleDetails.id, for: indexPath)
        
        return cell
    }
}
