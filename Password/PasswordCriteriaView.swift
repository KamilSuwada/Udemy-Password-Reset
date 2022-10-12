//
//  PasswordCriteriaView.swift
//  Password
//
//  Created by Kamil Suwada on 12/07/2022.
//

import UIKit




class PasswordCriteriaView: UIView {
    
    
    let stackView: UIStackView =
    {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 8
        return stack
    }()
    
    
    let imageView: UIImageView =
    {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    
    let criteriaLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
    
    var isCriteriaMet: Bool = false
    {
        didSet
        {
            if isCriteriaMet
            {
                imageView.image = checkmarkImage
            }
            else
            {
                imageView.image = xmarkImage
            }
        }
    }
    
    
    func reset()
    {
        isCriteriaMet = false
        imageView.image = circleImage
    }
    
    
    init(text: String) {
        super.init(frame: .zero)
        self.criteriaLabel.text = text
        self.style()
        self.layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
    
}




// MARK: Style and Layout:
extension PasswordCriteriaView {
    
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(criteriaLabel)
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: criteriaLabel.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 0),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 0)
        ])
        
        
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        criteriaLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    
    var isCheckMarkImage: Bool
    {
        return imageView.image == checkmarkImage
    }
    
    var isXmarkImage: Bool
    {
        return imageView.image == xmarkImage
    }
    
    var isResetImage: Bool
    {
        return imageView.image == circleImage
    }
    
    
}
