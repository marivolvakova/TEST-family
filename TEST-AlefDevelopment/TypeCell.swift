//
//  TypeCell.swift
//  TEST-AlefDevelopment
//
//  Created by Мария Вольвакова on 25.10.2022.
//

import UIKit
import SnapKit


class TypeCell: UITableViewCell {
    static let identifier = "TypeCell"
    
    func createTextField() -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.text = ""
        return textField
    }
    
    func createPlaceholderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }
    
    lazy var deleteChildButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 50 / 2
        button.titleLabel?.textColor = .systemBlue
        return button
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var chaildNameTextField = createTextField()
    lazy var chaildAgeTextField = createTextField()
    lazy var chaildNamePlaceholderLabel = createPlaceholderLabel(text: "Имя")
    lazy var chaildAgePlaceholderLabel = createPlaceholderLabel(text: "Возраст")
    
    
    func setUpView() {
        contentView.addSubview(chaildNameTextField)
        chaildNameTextField.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-190)
            make.height.equalTo(60)
        }
        contentView.addSubview(chaildNamePlaceholderLabel)
        chaildNamePlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(chaildNameTextField.snp.top).offset(5)
            make.left.equalTo(chaildNameTextField.snp.left).offset(15)
        }
        contentView.addSubview(chaildAgeTextField)
        chaildAgeTextField.snp.makeConstraints { make in
            make.top.equalTo(chaildNameTextField.snp.bottom).offset(20)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-190)
            make.height.equalTo(60)
        }
        contentView.addSubview(chaildAgePlaceholderLabel)
        chaildAgePlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(chaildAgeTextField.snp.top).offset(5)
            make.left.equalTo(chaildAgeTextField.snp.left).offset(15)
        }
        contentView.addSubview(deleteChildButton)
        deleteChildButton.snp.makeConstraints { make in
            make.centerY.equalTo(chaildNameTextField.snp.centerY)
            make.left.equalTo(chaildNameTextField.snp.right).offset(10)
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(chaildAgeTextField.snp.bottom).offset(20)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
