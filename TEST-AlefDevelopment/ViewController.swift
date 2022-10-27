//
//  ViewController.swift
//  TEST-AlefDevelopment
//
//  Created by Мария Вольвакова on 24.10.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - PROPERTIES
    
    var textFields: [Int] = []
    var textFieldNamesArray = [String]()
    var textFieldAgeArray = [String]()
    
    lazy var nameTextField = createTextField()
    lazy var ageTextField = createTextField()
    
    lazy var namePlaceholderLabel = createPlaceholderLabel(text: "Имя")
    lazy var agePlaceholderLabel = createPlaceholderLabel(text: "Возраст")
    
    lazy var personalDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Персональные данные"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var childrenLabel: UILabel = {
        let label = UILabel()
        label.text = "Дети (макс.5)"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var addChildButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 50 / 2
        button.imageEdgeInsets.left = -15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.titleLabel?.textColor = .systemBlue
        button.addTarget(self, action: #selector(addChaild), for: .touchUpInside)
        return button
    }()
    
    lazy var clearAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 50 / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.titleLabel?.textColor = .red
        button.addTarget(self, action: #selector(clearAll), for: .touchUpInside)
        return button
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 200)
        scrollView.frame = view.bounds
        return scrollView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // MARK: - FUNCTIONS
    
    func createTextField() -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
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
    
    @objc func addChaild() {
        let textField = Int()
        if textFields.count <= 5 {
            textFields.append(textField)
            textFieldNamesArray.insert("", at: textFields.count - 1)
            textFieldAgeArray.insert("", at: textFields.count - 1)
            tableView.insertRows(at: [IndexPath(row: textFields.count - 1, section: 0)], with: .automatic)
            tableView.reloadData()
        }
        if textFields.count == 5 {
            addChildButton.isHidden = true
        }
    }
    
    @objc func clearAll() {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let alertClear = UIAlertAction(title: "Сбросить данные", style: .default) {_ in
            self.textFields.removeAll()
            self.nameTextField.text = ""
            self.ageTextField.text = ""
            self.tableView.reloadData()
            self.addChildButton.isHidden = false
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(alertClear)
        alert.addAction(alertCancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func deleteChaild(_ sender: UIButton) {
        textFields.removeLast()
        let row = sender.tag
        textFieldNamesArray.remove(at: row)
        textFieldAgeArray.remove(at: row)
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        tableView.reloadData()
        addChildButton.isHidden = false
    }
    
    @objc func ageTextfieldChanged(_ sender: UITextField) {
        let newAge = sender.text
        let rowTag = sender.tag
        textFieldAgeArray[rowTag] = newAge ?? ""
        tableView.reloadData()
    }
    
    @objc func nameTextfieldChanged(_ sender: UITextField) {
        let newAge = sender.text
        let rowTag = sender.tag
        textFieldNamesArray[rowTag] = newAge ?? ""
        tableView.reloadData()
    }
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        tableView.register(TypeCell.self, forCellReuseIdentifier: TypeCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func layout() {
        view.addSubview(personalDataLabel)
        view.addSubview(nameTextField)
        nameTextField.addSubview(namePlaceholderLabel)
        view.addSubview(ageTextField)
        ageTextField.addSubview(agePlaceholderLabel)
        view.addSubview(childrenLabel)
        view.addSubview(addChildButton)
        view.addSubview(tableView)
        view.addSubview(clearAllButton)
        
        personalDataLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(personalDataLabel.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(60)
        }
        ageTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(60)
        }
        namePlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.top).offset(5)
            make.left.equalTo(nameTextField.snp.left).offset(15)
        }
        agePlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(ageTextField.snp.top).offset(5)
            make.left.equalTo(ageTextField.snp.left).offset(15)
        }
        childrenLabel.snp.makeConstraints { make in
            make.top.equalTo(ageTextField.snp.bottom).offset(35)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.equalTo(150)
        }
        addChildButton.snp.makeConstraints { make in
            make.centerY.equalTo(childrenLabel.snp.centerY)
            make.right.equalTo(view.snp.right).offset(-20)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(childrenLabel.snp.top).offset(40)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom).offset(-150)
        }
        clearAllButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(-100)
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.centerX.equalTo(tableView.snp.centerX)
        }
    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textFields.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TypeCell.identifier, for: indexPath) as? TypeCell {
            cell.deleteChildButton.addTarget(self, action: #selector(deleteChaild), for: .touchUpInside)
            cell.chaildNameTextField.text = textFieldNamesArray[indexPath.row]
            cell.chaildAgeTextField.text = textFieldAgeArray[indexPath.row]
            cell.chaildNameTextField.delegate = self
            cell.chaildAgeTextField.delegate = self
            cell.chaildNameTextField.addTarget(self, action: #selector(nameTextfieldChanged), for: .editingChanged)
            cell.chaildAgeTextField.addTarget(self, action: #selector(ageTextfieldChanged), for: .editingChanged)
            cell.chaildNameTextField.tag = indexPath.row
            cell.chaildAgeTextField.tag = indexPath.row
            cell.deleteChildButton.tag = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
}
