//
//  ViewController.swift
//  Password
//
//  Created by Kamil Suwada on 12/07/2022.
//

import UIKit




class DummyVC: UIViewController
{
    
    let stackView = UIStackView()
    let passwordTextField = PasswordTextField("New password")
    let passwordStatusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField("Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    
}




// MARK: style and layout:
extension DummyVC
{
    
    func setup()
    {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
        
        
        let newPasswordValidation: PasswordTextField.CustomValidation =
        { text in
            guard let text = text, !text.isEmpty else { return (false, "Enter your new password.") }
            
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else { self.passwordStatusView.reset(); return (false, "Invalid characters were used.") }
            
            self.passwordStatusView.updateDisplay(text)
            if !self.passwordStatusView.validate(text)
            {
                return (false, "Password must meet criteria below:")
            }
            
            return (true, "")
        }
        
        
        let confirmPasswordValidation: PasswordTextField.CustomValidation =
        { text in
            guard let text = text, !text.isEmpty else { return (false, "Enter your new password again.") }
            guard text == self.passwordTextField.text else { return (false, "Passwords do not match. Please check.") }
            return (true, "")
        }
        
        
        passwordTextField.customValidation = newPasswordValidation
        confirmPasswordTextField.customValidation = confirmPasswordValidation
        
        // KEYBOARD HANDLING:
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc private func keyboardWillShow(_ notification: NSNotification)
    {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY + 20 > keyboardTopY
        {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
        else
        {
            print(textFieldBottomY)
            print(keyboardTopY)
        }
    }
    
    
    @objc private func keyboardWillHide(_ notification: NSNotification)
    {
        view.frame.origin.y = 0
    }
    
    
    @objc private func viewTapped(_ recognizer: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    
    func style()
    {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 50
        
        
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        
        
        passwordStatusView.translatesAutoresizingMaskIntoConstraints = false
        passwordStatusView.layer.cornerRadius = 15
        passwordStatusView.clipsToBounds = true
        
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.delegate = self
        
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset Password", for: [])
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    
    func layout()
    {
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordStatusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            passwordStatusView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            passwordStatusView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            resetButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            resetButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
    
    
    @objc private func resetButtonTapped(_ sender: UIButton)
    {
        view.endEditing(true)
        
        let isValidNewPassword = passwordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()
        
        if isValidNewPassword && isValidConfirmPassword
        {
            showAlert(title: "Seccess", message: "You have successfully changed your password.")
        }
    }
    
    
    
    private func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
}




// MARK: PasswordTextFieldDelegate conformance and related logic:
extension DummyVC: PasswordTextFieldDelegate
{
    
    func editingDidEnd(_ sender: PasswordTextField)
    {
        passwordStatusView.shouldResetCriteria = false
        if sender === self.passwordTextField { _ = passwordTextField.validate() }
        else if sender === self.confirmPasswordTextField { _ = confirmPasswordTextField.validate() }
    }
    
    
    func textDidChangeInTextField(_ sender: PasswordTextField)
    {
        if sender === passwordTextField
        {
            let text = sender.textField.text!
            passwordStatusView.updateDisplay(text)
        }
    }
    
}




extension UIResponder
{
    private struct Static
    {
        static weak var responder: UIResponder?
    }
    
    
    static func currentFirst() -> UIResponder?
    {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    
    @objc private func _trap()
    {
        Static.responder = self
    }
}
