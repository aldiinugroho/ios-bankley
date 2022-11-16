//
//  AccountSummaryHeaderView.swift
//  bankley
//
//  Created by aldinugroho on 07/11/22.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    let descStackView = UIStackView()
    let descnimageStackView = UIStackView()
    let titleLabel = UILabel()
    let greetingLabel = UILabel()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let imageView = UIImageView()
    
    let imageBoxView = UIView()
    
    struct ViewModel {
        let welcomeMessage: String
        let name: String
        let date: Date
        
        var dateFormatted: String {
            return date.monthDayYearString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryHeaderView {
    func style() {
        self.backgroundColor = appColor
        
        descnimageStackView.translatesAutoresizingMaskIntoConstraints = false
        descnimageStackView.axis = .horizontal
        descnimageStackView.distribution = .equalSpacing
        descnimageStackView.alignment = .leading
//        descnimageStackView.backgroundColor = .systemPink
        
        descStackView.translatesAutoresizingMaskIntoConstraints = false
        descStackView.axis = .vertical
        descStackView.spacing = 5
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.text = "Bankley"
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.text = "Good Morning,"
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Jonathan"
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "Date"
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 60, weight: .light, scale: .default)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "sun.max.fill", withConfiguration: configuration)
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
    }
    
    func layout() {
        self.addSubview(descnimageStackView)
        
        descStackView.addArrangedSubview(titleLabel)
        descStackView.addArrangedSubview(greetingLabel)
        descStackView.addArrangedSubview(nameLabel)
        descStackView.addArrangedSubview(dateLabel)

        descnimageStackView.addArrangedSubview(descStackView)
        descnimageStackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            descnimageStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            descnimageStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descnimageStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: descnimageStackView.trailingAnchor, multiplier: 2)
        ])
    }
}

extension AccountSummaryHeaderView {
    func configure(viewModel: ViewModel) {
        greetingLabel.text = viewModel.welcomeMessage
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.dateFormatted
    }
}
