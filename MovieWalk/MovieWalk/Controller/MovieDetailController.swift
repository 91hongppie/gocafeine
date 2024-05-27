//
//  MovieDetailController.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import UIKit
import SDWebImage

class MovieDetailController: UIViewController {
    
    // MARK: - Properties
    
    private var movieId: String
    
    private var movieDetail: MovieDetail? {
        didSet {
            configure()
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black


        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel = CustomLabel()
    private let directorLabel = CustomLabel()
    private let actorsLabel = CustomLabel()
    private let releaseLabel = CustomLabel()
    private let ratingLabel = CustomLabel()
    private let plotLabel = CustomLabel()
    
    private lazy var titleView = CustomTextView(title: "제목", label: self.titleLabel)
    private lazy var directorView = CustomTextView(title: "감독", label: directorLabel)
    private lazy var actorsView = CustomTextView(title: "출연", label: self.actorsLabel)
    private lazy var releaseView = CustomTextView(title: "개봉일자", label: self.releaseLabel)
    private lazy var ratingView = CustomTextView(title: "평점", label: self.ratingLabel)
    private lazy var plotView = CustomTextView(title: "줄거리", label: self.plotLabel)

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        fetchMovieDetail()
        
    }

    
    init(movieId: String) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    func fetchMovieDetail() {
        showLoader(true)
        MovieService.shared.fetchMovieDetail(withId: movieId) { movieDetail, error in
            if let _ = error {
                DispatchQueue.main.async {
                    self.showError("영화 정보를 불러오는데 실패했습니다.")
                }
                return
            }
            self.movieDetail = movieDetail
        }
        showLoader(false)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingBottom: 20)
    
        
        scrollView.addSubview(contentView)
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor ,right: scrollView.rightAnchor)
        contentView.setWidth(width: view.frame.width)
        
        
        contentView.addSubview(posterImageView)
        posterImageView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
        
        contentView.addSubview(titleView)
        
        let stack = UIStackView(arrangedSubviews: [titleView, directorView, actorsView, releaseView, ratingView, plotView])
        stack.axis = .vertical
        stack.spacing = 12
        
        contentView.addSubview(stack)
        stack.anchor(top: posterImageView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor,paddingTop: 50, paddingLeft: 20, paddingRight: 20)
        
        
        
        
    }
    
    func configure() {
        guard let movieDetail = movieDetail else { return }
        guard let url = URL(string: movieDetail.Poster) else { return }
        posterImageView.sd_setImage(with: url)
        DispatchQueue.main.async {
            self.configureUI()
            self.titleLabel.text = movieDetail.Title
            self.directorLabel.text = movieDetail.Director
            self.actorsLabel.text = movieDetail.Actors
            self.releaseLabel.text = movieDetail.Released
            self.ratingLabel.text = movieDetail.Ratings
            self.plotLabel.text = movieDetail.Plot
        }
    }
}
