//
//  ViewController.swift
//  MVC-Coordinator
//
//  Created by Willian Magnum Albeche on 04/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movieList: MovieList?
    var movie: MovieList?
    private var service = QueryService()
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            guard let viewController = segue.destination as? DetailsViewController else{
                print(Error.self)
                return
            }
        }
    }
    
    private func getData() {
        dispatchGroup.enter()
        service.getComicsMovies { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movieList):
                self.dispatchGroup.leave()
                self.movieList = movieList
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    private func loadTableView(){
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TableViewCell.id)
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier:"showDetails", sender: nil)
    }
}






