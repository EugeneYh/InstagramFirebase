//
//  RegistrationScreenViewController.swift
//  InstagramFirebase App
//
//  Created by Eugene on 09.07.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth



class RegistrationScreenViewController: UIViewController {
    
    //MARK: - UI elements section
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing Up", for: .normal)
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleSingUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    //MARK: - Firebase - create a new user
    
    @objc fileprivate func handleSingUp() {
        guard let email = emailTextField.text, email.count > 0 else { return }
        guard let username = usernameTextField.text, username.count > 0 else { return }
        guard let password = passwordTextField.text, password.count > 0 else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authInfo, error) in
            if let error = error {
                print("Error while creating new user", error)
                return
            }
            print("succes", authInfo?.user.uid ?? "")
        }
    }
    
    //MARK: - Text fields validation
    
    @objc fileprivate func handleTextInputChange() {
        guard let email = emailTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if email.count > 0 && username.count > 0 && password.count > 0 {
            singUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
            singUpButton.isEnabled = true
        } else {
            singUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            singUpButton.isEnabled = false
        }
    }
    
    
    fileprivate func setupView() {
        let verticalStackView = UIStackView(arrangedSubviews: [emailTextField,
                                                               usernameTextField,
                                                               passwordTextField,
                                                               singUpButton])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 12
        verticalStackView.distribution = .fillEqually
        
        view.addSubview(plusPhotoButton)
        view.addSubview(verticalStackView)
                
        plusPhotoButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(140)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(18)
            make.centerX.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints { (make) in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
    }
}
