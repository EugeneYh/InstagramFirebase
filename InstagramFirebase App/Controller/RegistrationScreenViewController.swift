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
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing Up", for: .normal)
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleSingUp), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleSingUp() {
        let email = "dummy@gmail.com"
        let pass = "123456"
        
        Auth.auth().createUser(withEmail: email, password: pass) { (authInfo, error) in
            if let error = error {
                print("Error while creating new user", error)
                return
            }
            print("succes", authInfo?.user.uid ?? "")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
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
