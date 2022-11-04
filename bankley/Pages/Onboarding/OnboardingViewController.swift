//
//  OnboardingViewController.swift
//  bankley
//
//  Created by aldinugroho on 04/11/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let labelView = UILabel()
    
    let heroImageName: String
    let titleText: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    init(heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // IMAGE
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: heroImageName)
        
        // LABEL
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.numberOfLines = 0
        labelView.adjustsFontForContentSizeCategory = true
        labelView.textAlignment = .center
        labelView.text = titleText
    }
    
    private func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelView)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}
