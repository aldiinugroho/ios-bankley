//
//  DummyViewController.swift
//  bankley
//
//  Created by aldinugroho on 04/11/22.
//

import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let labelView = UILabel()
    let logoutBtn = UIButton(type: .system)
    weak var delegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DummyViewController {
    private func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.text = "Welcome"
        
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.configuration = .filled()
        logoutBtn.setTitle("Logout", for: [])
        logoutBtn.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        stackView.addArrangedSubview(labelView)
        stackView.addArrangedSubview(logoutBtn)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension DummyViewController {
    @objc func logoutTapped (_ sender: UIButton) {
        delegate?.didLogout()
    }
}
