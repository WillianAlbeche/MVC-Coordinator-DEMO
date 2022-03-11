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
    var sections = Dictionary<String, [ListedMovie]>()
    var movie: ListedMovie?
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
        
        service.getPopularMovieList { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movieList):
                self.setSection(section: "Popular", movieList: movieList)
            }
        }
        
        service.getNowPlayingMovieList { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movieList):
                self.setSection(section: "Playing", movieList: movieList)
            }
        }
        
        dispatchGroup.leave()
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    private func setSection(section: String, movieList: MovieList) {
        self.sections[section] = movieList.results
    }
    
    private func getSectionKey(index: Int) -> String {
        switch index {
        case 0:
            return "Popular"
        case 1:
            return "Playing"
        default:
            return ""
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getSectionKey(index: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionList = self.sections[getSectionKey(index: section)] else {
            return 0
        }
        
        if section == 0 {
            return 2
        }
        
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell else{
            print(Error.self)
            return UITableViewCell()
        }
        
        let sectionKey = getSectionKey(index: indexPath.section)
        
        if let movie = sections[sectionKey]?[indexPath.row] {
            cell.imageCell.loadImage(withUrl: ImageHelpers.getImageURL(path: movie.posterPath))
            cell.titleCell.text = movie.title
            cell.descriptionCell.text = movie.overview
            cell.ratingCell.text = String(movie.voteAverage)
            
            self.movie = movie
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sectionKey = getSectionKey(index: indexPath.section)
        if let movie = sections[sectionKey]?[indexPath.row] {
            coordinator?.showMovieDetails(movie: movie.id, path: movie.posterPath)
        }
    }
}
