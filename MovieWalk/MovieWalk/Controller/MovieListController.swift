//
//  MovieListController.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MovieListController: UITableViewController {

 
    // MARK: - Properties
    
    private var movies: [Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                if self.movies.count == 0 {
                    self.noResultLabel.textColor = .white
                } else {
                    self.noResultLabel.textColor = .clear
                }
                self.tableView.reloadData()
            }
        }
    }
    private var searchText: String = "" {
        didSet {
            initData()
        }
    }
    private var page: Int = 1 {
        didSet {
            fetchMovie()
        }
    }
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let noResultLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.text = "검색 결과가 없습니다."
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSearchController()
        searchText = "star"
    }
    
    // MARK: - Selectors
    
    @objc func dismissKeyboard() {
        searchController.searchBar.endEditing(true)
    }
    
    // MARK: - API
    
    func fetchMovie() {
        showLoader(true)
        MovieService.shared.fetchMovieList(withSearch: searchText, page: page) { movieList, error in
            if let _ = error {
                DispatchQueue.main.async {
                    self.showError("영화 목록을 불러오는데 실패했습니다.")
                }
                return
            }
            guard let movieList = movieList else { return }
            self.movies = self.movies + movieList
        }
        showLoader(false)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .black
        configureNavigationBar(withTitle: "영화 목록", prefersLargeTitles: false)
        
        tableView.addSubview(noResultLabel)
        noResultLabel.centerX(inView: view)
        noResultLabel.anchor(top: self.tableView.topAnchor, paddingTop: 24)
        
        
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func configureSearchController() {
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for movies"
        searchController.searchBar.delegate = self
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.spellCheckingType = .no
        definesPresentationContext = false
    }
    
    func initData() {
        movies = []
        page = 1
    }
    
    func showSearchBar() {
        searchController.isActive = true
    }
    
    func hideSearchBar() {
        searchController.isActive = false
    }
}

// MARK: - SearchBarDelegate

extension MovieListController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.lowercased() else { return }
        if self.searchText == searchText {
            return
        }
        self.searchText = searchText
    }
}

// MARK: - TableViewDataSource

extension MovieListController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}

// MARK: - TableViewDelegate

extension MovieListController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let direction = scrollView.panGestureRecognizer.velocity(in: scrollView)
        if direction.y > 0 {
            showSearchBar()
        } else if direction.y < 0 {
            hideSearchBar()
        }
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            self.page += 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = movies[indexPath.row].imdbID
        let controller = MovieDetailController(movieId: id)
        navigationController?.pushViewController(controller, animated: true)
    }
}
