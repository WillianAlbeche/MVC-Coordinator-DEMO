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
    
    // let movieList = movies
    // var movie: DCEU_Movie?
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
            viewController.movie = self.movie
        }
    }
    
    private func getData() {
        dispatchGroup.enter()
        service.getMovieList { result in
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
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell else{
            print(Error.self)
            return UITableViewCell()
        }
        cell.imageCell.image = UIImage(named: movieList[indexPath.row].imageName)
        cell.titleCell.text = movieList[indexPath.row].title
        cell.descriptionCell.text = movieList[indexPath.row].description
        cell.ratingCell.text = movieList[indexPath.row].userScore
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movie = movieList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier:"showDetails", sender: nil)
    }
}






