//
//  SignupViewController.swift
//  BeyondWunder
//
//  Created by hoemoon on 07/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit
import RealmSwift

class SignupViewController: UIViewController {
    var idTextField = UITextField()
    var pwTextField = UITextField()
    var signUpBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        idTextField = UITextField(frame: CGRect(x: 50, y: 300, width: 225, height: 30))
        idTextField.autocapitalizationType = .none
        idTextField.borderStyle = UITextBorderStyle.roundedRect
        idTextField.placeholder = "enter id"
        idTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        
        pwTextField = UITextField(frame: CGRect(x: 50, y: 335, width: 225, height: 30))
        pwTextField.autocapitalizationType = .none
        pwTextField.borderStyle = UITextBorderStyle.roundedRect
        pwTextField.placeholder = "enter password"
        pwTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        
        signUpBtn = UIButton(type: .system)
        signUpBtn.setTitle("CREATE ACCOUNT", for: .normal)
        signUpBtn.frame = CGRect(x: 80, y: 400, width: 150, height: 50)
        signUpBtn.addTarget(self, action: #selector(signUp), for: UIControlEvents.touchUpInside)
        signUpBtn.isEnabled = false
        
        view.addSubview(idTextField)
        view.addSubview(pwTextField)
        view.addSubview(signUpBtn)

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidChange(textField: UITextField) {
        if !(idTextField.text?.isEmpty)! && !(pwTextField.text?.isEmpty)! {
            signUpBtn.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signUp() {
        print("Sign Up")
        let userCredentials = SyncCredentials.usernamePassword(username: idTextField.text!, password: pwTextField.text!, register: true)
        let serverURL = URL(string: "http://127.0.0.1:9080/")
        SyncUser.logIn(with: userCredentials, server: serverURL!) { user, error in
            if let user = user {
                // can now open a synchronized Realm with this user
                print(user)
                DispatchQueue.main.async {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard", bundle:nil)
                    let taskListVC = storyBoard.instantiateViewController(withIdentifier: "taskList") as! TaskListViewController
                    self.present(taskListVC, animated: true, completion: nil)
                }
            } else if let error = error {
                print(error)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
