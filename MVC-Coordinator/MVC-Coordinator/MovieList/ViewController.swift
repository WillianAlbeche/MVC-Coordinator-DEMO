//
//  ViewController.swift
//  MVC-Coordinator
//
//  Created by Willian Magnum Albeche on 04/03/22.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    
    var movieList = MovieList()
    private var service = QueryService()
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        loadTableView()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let search = UISearchController(searchResultsController: nil)
        
        self.navigationItem.searchController = search
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
        return movieList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell else{
            print(Error.self)
            return UITableViewCell()
        }
        cell.imageCell.loadImage(withUrl: ImageHelpers.getImageURL(path: movieList.results[indexPath.row].posterPath))
        cell.titleCell.text = movieList.results[indexPath.row].title
        cell.descriptionCell.text = movieList.results[indexPath.row].overview
        cell.ratingCell.text = String(movieList.results[indexPath.row].voteAverage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieList.results[indexPath.row]
        coordinator?.showMovieDetails(movie: movie.id, path: movie.posterPath)
    }
}






