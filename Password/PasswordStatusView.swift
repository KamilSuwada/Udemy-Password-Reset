//
//  PasswordStatusView.swift
//  Password
//
//  Created by Kamil Suwada on 12/07/2022.
//

import UIKit




class PasswordStatusView: UIView {
    
    
    let stackView: UIStackView =
    {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 8
        return stack
    }()
    
    
    let lengthCriteriaView: PasswordCriteriaView =
    {
        let view = PasswordCriteriaView(text: "8-32 characters (no spaces)")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let criteriaLabel: UILabel =
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        var txt = NSMutableAttributedString(string: "Use at least ", attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
        txt.append(NSAttributedString(string: "3 ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.label, NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .subheadline)]))
        txt.append(NSAttributedString(string: "of these ", attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel]))
        txt.append(NSAttributedString(string: "4 ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.label, NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .subheadline)]))
        txt.append(NSAttributedString(string: "criteria when setting your pasword:", attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .subheadline), NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel]))
        label.attributedText = txt
        return label
    }()
    
    
    let uppercaseCriteriaView: PasswordCriteriaView =
    {
        let view = PasswordCriteriaView(text: "uppercase letter (A-Z)")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let lowercaseCriteriaView: PasswordCriteriaView =
    {
        let view = PasswordCriteriaView(text: "lowercase letter (a-z)")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let digitCriteriaView: PasswordCriteriaView =
    {
        let view = PasswordCriteriaView(text: "digit (0-9)")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let specialCharacterCriteriaView: PasswordCriteriaView =
    {
        let view = PasswordCriteriaView(text: "special character (e.g. !@#%^)")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    public var shouldResetCriteria: Bool = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.style()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    
}




// MARK: Style and Layout:
extension PasswordStatusView {
    
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
    }
    
    
    func layout() {
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowercaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
    }
    
    
}




// MARK: - Actions:
extension PasswordStatusView
{
    
    func updateDisplay(_ text: String)
    {
        let lengthNoSpacesMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let upperCaseMet = PasswordCriteria.upperCaseMet(text)
        let lowerCaseMet = PasswordCriteria.lowerCaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharMet = PasswordCriteria.specialCharMet(text)
        
        if shouldResetCriteria == true
        {
            lengthNoSpacesMet
            ? lengthCriteriaView.isCriteriaMet = true
            : lengthCriteriaView.reset()
            
            upperCaseMet
            ? uppercaseCriteriaView.isCriteriaMet = true
            : uppercaseCriteriaView.reset()
            
            lowerCaseMet
            ? lowercaseCriteriaView.isCriteriaMet = true
            : lowercaseCriteriaView.reset()
            
            digitMet
            ? digitCriteriaView.isCriteriaMet = true
            : digitCriteriaView.reset()
            
            specialCharMet
            ? specialCharacterCriteriaView.isCriteriaMet = true
            : specialCharacterCriteriaView.reset()
        }
        else
        {
            lengthCriteriaView.isCriteriaMet = lengthNoSpacesMet
            uppercaseCriteriaView.isCriteriaMet = upperCaseMet
            lowercaseCriteriaView.isCriteriaMet = lowerCaseMet
            digitCriteriaView.isCriteriaMet = digitMet
            specialCharacterCriteriaView.isCriteriaMet = specialCharMet
        }
    }
    
    
    func validate(_ text: String) -> Bool
    {
        let lengthNoSpacesMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let upperCaseMet = PasswordCriteria.upperCaseMet(text)
        let lowerCaseMet = PasswordCriteria.lowerCaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharMet = PasswordCriteria.specialCharMet(text)
        
        let checkable = [lengthNoSpacesMet,upperCaseMet,lowerCaseMet,digitMet,specialCharMet]
        let metCriteria = checkable.filter { $0 }
        
        if lengthNoSpacesMet == true && metCriteria.count >= 3 { return true }
        else { return false }
    }
    
    
    func reset()
    {
        lengthCriteriaView.reset()
        uppercaseCriteriaView.reset()
        lowercaseCriteriaView.reset()
        digitCriteriaView.reset()
        specialCharacterCriteriaView.reset()
    }
    
}
