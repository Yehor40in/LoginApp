//
//  InputView.swift
//  LoginApp
//
//  Created by Yehor Sorokin on 20.01.2021.
//

import UIKit


final class InputView: UIView {

    // MARK: Properties
    var titleText: String?
    var placeholder: String?
    var errorMessage: String?
    
    var isInvalid = false {
        didSet {
            notify()
        }
    }
    
    static var labelBottomOffset: CGFloat = 5
    static var labelHeight: CGFloat = 20
    static var fieldHeight: CGFloat = 50
    static var prefferedHeight: CGFloat {
        (labelHeight * 2) + fieldHeight + (labelBottomOffset * 2)
    }

    private var errorHeightConstraint: NSLayoutConstraint?
    
    
    // MARK: Subviews
    lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Config.fieldLabelFont
        return label
    }()
    
    lazy var inputField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = Config.prefferedCornerRadius
        textField.delegate = self
        textField.backgroundColor = Config.fieldColor
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = Config.fieldLabelFont
        label.textColor = UIColor.red
        return label
    }()
    
    
    // MARK: Initializarion
    convenience init(frame: CGRect = CGRect.zero, title: String, errorMessage: String, placeholder: String) {
        self.init(frame: frame)
        self.placeholder = placeholder
        self.titleText = title
        self.errorMessage = errorMessage
        configureSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupConstraints()
    }
    
    
    // MARK: Methods
    private func commonInit() -> Void {
        addSubview(inputLabel)
        addSubview(inputField)
        addSubview(errorLabel)
    }
    
    private func configureSubviews() -> Void {
        if let labelTitle = titleText, let placeholder = placeholder {
            inputLabel.text = labelTitle
            inputField.placeholder = placeholder
            errorLabel.text = errorMessage
        }
    }
    
    private func setupConstraints() -> Void {
        NSLayoutConstraint.activate([
            inputLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputLabel.topAnchor.constraint(equalTo: topAnchor),
            inputLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputLabel.heightAnchor.constraint(equalToConstant: InputView.labelHeight),
            
            inputField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputField.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: InputView.labelBottomOffset),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputField.heightAnchor.constraint(equalToConstant: InputView.fieldHeight),
            
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.topAnchor.constraint(equalTo: inputField.bottomAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        errorHeightConstraint = errorLabel.heightAnchor.constraint(equalToConstant: 0)
        errorHeightConstraint?.isActive = true
        
    }
    
    
    private func notify() -> Void {
        errorHeightConstraint?.constant = isInvalid ? InputView.labelHeight : 0
        UIView.animate(withDuration: Config.animationDuration, animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }

}


// MARK: UITextFielDelegate
extension InputView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
