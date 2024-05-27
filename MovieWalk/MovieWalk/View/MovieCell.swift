//
//  MovieCell.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    // MARK: - Properties
    
    var movie: Movie? {
        didSet {
            configure()
        }
    }
    
    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        self.backgroundColor = .black
        addSubview(posterImageView)
        posterImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        posterImageView.setDimensions(height: 56, width: 56)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, releaseLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: posterImageView.rightAnchor, paddingLeft: 12)
        stack.anchor(right: rightAnchor, paddingRight: 12)
    }
    
    func configure() {
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        releaseLabel.text = movie.year
        
        guard let url = URL(string: movie.poster) else { return }
        posterImageView.sd_setImage(with: url)
    }
}
