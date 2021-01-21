//
//  ViewController.swift
//  LoginApp
//
//  Created by Yehor Sorokin on 20.01.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: Subviews
    lazy var primaryStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.layoutMargins = Config.primaryLayoutMargins
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Sign In"
        label.font = Config.titleFont
        return label
    }()
    
    lazy var loginField: InputView = {
        let input = InputView(title: "Email", errorMessage: "Login cannot be empty!", placeholder: "Your email")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    lazy var passwordField: InputView = {
        let input = InputView(title: "Password", errorMessage: "Password cannot be empty!", placeholder: "Your password")
        input.translatesAutoresizingMaskIntoConstraints = false
        input.inputField.isSecureTextEntry = true
        return input
    }()
    
    lazy var signUpButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.systemIndigo, for: .normal)
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = Config.buttonFont
        return btn
    }()
    
    lazy var forgotPassButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.systemIndigo, for: .normal)
        btn.setTitle("Forgot a password?", for: .normal)
        btn.titleLabel?.font = Config.buttonFont
        return btn
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.systemIndigo
        btn.layer.cornerRadius = Config.prefferedCornerRadius
        btn.tintColor = UIColor.white
        btn.setTitle("Sign in", for: .normal)
        btn.titleLabel?.font = Config.buttonFont
        btn.layer.shadowOffset = CGSize(width: 0, height: 10)
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.addTarget(self, action: #selector(buttonPrimaryAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()
    
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        Auth.shared.delegate = self
    }

    
    // MARK: Methods
    private func setupSubviews() -> Void {
        primaryStackView.addArrangedSubview(titleLabel)
        primaryStackView.addArrangedSubview(loginField)
        primaryStackView.addArrangedSubview(passwordField)
        primaryStackView.addArrangedSubview(loginButton)
        primaryStackView.addArrangedSubview(signUpButton)
        primaryStackView.addArrangedSubview(forgotPassButton)
        
        primaryStackView.setCustomSpacing(10, after: passwordField)
        primaryStackView.setCustomSpacing(30, after: loginButton)
        
        view.addSubview(primaryStackView)
        view.addSubview(indicator)
    }
    
    private func setupConstraints() -> Void {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: Config.titleHeight),
            loginField.heightAnchor.constraint(equalToConstant: InputView.prefferedHeight),
            passwordField.heightAnchor.constraint(equalToConstant: InputView.prefferedHeight),
            loginButton.heightAnchor.constraint(equalToConstant: InputView.fieldHeight),
            signUpButton.heightAnchor.constraint(equalToConstant: InputView.fieldHeight),
            forgotPassButton.heightAnchor.constraint(equalToConstant: InputView.fieldHeight),
            
            primaryStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            primaryStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            primaryStackView.topAnchor.constraint(equalTo: view.topAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 200),
            indicator.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    @objc private func buttonPrimaryAction(_ sender: UIButton) -> Void {
        
        var credentials = [String:String]()
        
        if let login = loginField.inputField.text {
            credentials["email"] = login
            loginField.isInvalid = login.isEmpty
        }
        if let passwd = passwordField.inputField.text {
            credentials["password"] = passwd
            passwordField.isInvalid = passwd.isEmpty
        }
        
        let error = loginField.isInvalid || passwordField.isInvalid
        if !error {
            indicator.isHidden = false
            indicator.startAnimating()
            credentials["project_id"] = Config.project_id
            Auth.shared.tryAuthenticate(using: credentials)
        }
    }
    
    
    private func showAlert() -> Void {
        let alert = UIAlertController(title: "Error", message: "Invalid credentials", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {}

}


extension ViewController: AuthDelegate {
    
    func didTryAuthenticate() {
        
        indicator.stopAnimating()
        indicator.isHidden = true
        
        if Auth.isAuthenticated {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            showAlert()
        }
    }
    
}
