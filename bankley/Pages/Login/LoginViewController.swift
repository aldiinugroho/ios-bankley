//
//  ViewController.swift
//  bankley
//
//  Created by aldinugroho on 03/11/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signinbutton = UIButton(type: .system)
    let errormsglabel = UILabel()
    let descriptionLabel = UILabel()
    let titleLabel = UILabel()
    
    var username: String? {
        return loginView.usernameTextfield.text
    }
    var password: String? {
        return loginView.passwordTextfield.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
}

extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signinbutton.translatesAutoresizingMaskIntoConstraints = false
        signinbutton.configuration = .filled()
        signinbutton.configuration?.imagePadding = 8
        signinbutton.setTitle("Sign in", for: [])
        signinbutton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errormsglabel.translatesAutoresizingMaskIntoConstraints = false
        errormsglabel.textAlignment = .center
        errormsglabel.textColor = .systemRed
        errormsglabel.numberOfLines = 0
        errormsglabel.isHidden = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Your premium source for \n all things banking!"
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Bankey"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        titleLabel.textAlignment = .center
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signinbutton)
        view.addSubview(errormsglabel)
        view.addSubview(descriptionLabel)
        view.addSubview(titleLabel)
        
        // LOGIN
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        // BUTTON
        NSLayoutConstraint.activate([
            signinbutton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signinbutton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signinbutton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // EEROR LABEL
        NSLayoutConstraint.activate([
            errormsglabel.topAnchor.constraint(equalToSystemSpacingBelow: signinbutton.bottomAnchor, multiplier: 2),
            errormsglabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errormsglabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // DESCRIPTION
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -50),
            descriptionLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // DESCRIPTION
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -35),
            titleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
}

extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errormsglabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "aldi" && password == "nugroho" {
            signinbutton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errormsglabel.isHidden = false
        errormsglabel.text = message
    }
}
