//
//  PasswordTextField.swift
//  Password
//
//  Created by Kamil Suwada on 12/07/2022.
//

import UIKit


protocol PasswordTextFieldDelegate: AnyObject
{
    func textDidChangeInTextField(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField)
}


class PasswordTextField: UIView
{
    typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let placeholderText: String
    let eyeButton = UIButton(type: .custom)
    let separator = UIView()
    let errorMessageLabel = UILabel()
    
    var customValidation: CustomValidation?
    weak var delegate: PasswordTextFieldDelegate?
    
    
    var text: String?
    {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    
    init(_ strPlaceholder: String)
    {
        self.placeholderText = strPlaceholder
        super.init(frame: .zero)
        self.style()
        self.layout()
    }
    
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented!")
    }
    
    
    override var intrinsicContentSize: CGSize
    {
        return CGSize(width: 200, height: 50)
    }
    
    
}




// MARK: Style and Layout:
extension PasswordTextField
{
    
    
    func style()
    {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.placeholder = placeholderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
        textField.addTarget(self, action: #selector(textDidChangeInTextField), for: .editingChanged)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.font = .preferredFont(forTextStyle: .footnote)
        errorMessageLabel.text = "Your password needs to meet all requirements below."
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.isHidden = true
    }
    
    
    func layout()
    {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(separator)
        addSubview(errorMessageLabel)
        
        
        NSLayoutConstraint.activate([
            
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
            
            
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            separator.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: separator.bottomAnchor, multiplier: 0.5),
            errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        
        lockImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    
    @objc private func eyeButtonTapped(_ sender: UIButton)
    {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    
}




// MARK: UITextFieldDelegate
extension PasswordTextField: UITextFieldDelegate
{
    
    @objc private func textDidChangeInTextField(_ sender: UITextField)
    {
        delegate?.textDidChangeInTextField(self)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        delegate?.editingDidEnd(self)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.endEditing(true)
        return true
    }
    
    
    func validate() -> Bool
    {
        if let customValidation = self.customValidation, let result = customValidation(text), result.0 == false
        {
            showError(result.1); return false
        }
        
        clearError()
        return true
    }
    
    
    private func showError(_ msg: String)
    {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = msg
    }
    
    
    private func clearError()
    {
        errorMessageLabel.isHidden = true
        errorMessageLabel.text = ""
    }
    
}
