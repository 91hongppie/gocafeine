//
//  CustomTextView.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import UIKit

class CustomTextView: UIView {
    
    init(title: String, label: CustomLabel) {
        super.init(frame: .zero)
        
        self.backgroundColor = .black
        
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.text = title
        titleLabel.textColor = .white
        
        label.font = .systemFont(ofSize: 16)
        label.text = description
        label.textColor = .lightGray
        label.numberOfLines = 0
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, label])
        stack.axis = .vertical
        stack.spacing = 8
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
