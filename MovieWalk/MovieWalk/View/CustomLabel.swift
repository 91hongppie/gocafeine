//
//  HeaderLabel.swift
//  MovieWalk
//
//  Created by Kyuhong Jo on 5/27/24.
//

import UIKit


class CustomLabel: UILabel {
    init() {
        super.init(frame: .zero)
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.text = ""
        label.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
