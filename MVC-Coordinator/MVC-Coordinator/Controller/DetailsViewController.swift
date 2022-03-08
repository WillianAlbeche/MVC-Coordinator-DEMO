//
//  DetailsViewController.swift
//  MVC-Coordinator
//
//  Created by Willian Magnum Albeche on 04/03/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie?
    var movieIdReceived: Int?
    var moviePosterPath: String?
    let dispatchGroup = DispatchGroup()
    private var service = QueryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movieId = self.movieIdReceived {
            getMovie(id: movieId)
        }
        loadTableView()
    }
    
    private func getMovie(id: Int) {
        dispatchGroup.enter()
        service.getMovie(movieId: id) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movie):
                self.dispatchGroup.leave()
                self.movie = movie
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
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
        var cellId:String = ""
        
        if indexPath.row == 0 {
            cellId = TableViewCellTitleDetails.id
            guard let cell = tableView.dequeueReusableCell(withIdentifier:cellId, for: indexPath) as? TableViewCellTitleDetails else{
                print(Error.self)
                return UITableViewCell()
            }
            if let movie = self.movie,
               let posterPath = self.moviePosterPath {
                cell.imageCell.loadImage(withUrl: ImageHelpers.getImageURL(path: posterPath))
                cell.ratingCell.text = String(movie.voteAverage)
                cell.titleCell.text = movie.title
            }
            return cell
        }
        
        cellId = TableViewCellDescriptionDetails.id
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as?
                TableViewCellDescriptionDetails else{
                    print(Error.self)
                    return UITableViewCell()
                }
        cell.resumeCell.text = movie?.overview
        
        return cell
    }
}
