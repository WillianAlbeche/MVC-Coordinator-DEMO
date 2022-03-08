//
//  DetailsViewController.swift
//  MVC-Coordinator
//
//  Created by Willian Magnum Albeche on 04/03/22.
//

import UIKit

class DetailsViewController: UIViewController {

    var movie: DCEU_Movie?
    @IBOutlet weak var tableView: UITableView!
    
    private var service = QueryService()
    var id: Int?
    var movieReceived: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movieId = self.id {
            getMovie(id: movieId)
            loadTableView()
        }
        loadTableView()
    }
    
    private func getMovie(id: Int) {
        service.getMovie(movieId: id) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movie):
                self.movieReceived = movie
            }
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
        return 2 //0 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId:String = ""
        
        if indexPath.row == 0{
            cellId = TableViewCellTitleDetails.id
            guard let cell = tableView.dequeueReusableCell(withIdentifier:cellId, for: indexPath) as? TableViewCellTitleDetails else{
                print(Error.self)
                return UITableViewCell()
            }
            if let movie = self.movie   {
                cell.imageCell.image =  UIImage(named: movie.imageName)
                cell.ratingCell.text = movie.userScore
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
        cell.resumeCell.text = movie?.description
        
        return cell
    }
}
