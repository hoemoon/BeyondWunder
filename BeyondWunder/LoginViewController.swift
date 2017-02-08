//
//  LoginViewController.swift
//  BeyondWunder
//
//  Created by hoemoon on 07/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    var idTextField = UITextField()
    var pwTextField = UITextField()
    var signInBtn = UIButton()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        idTextField = UITextField(frame: CGRect(x: 50, y: 300, width: 225, height: 30))
        idTextField.borderStyle = UITextBorderStyle.roundedRect
        idTextField.placeholder = "enter id"
        idTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        idTextField.autocapitalizationType = .none

        
        pwTextField = UITextField(frame: CGRect(x: 50, y: 335, width: 225, height: 30))
        pwTextField.borderStyle = UITextBorderStyle.roundedRect
        pwTextField.placeholder = "enter password"
        pwTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        pwTextField.autocapitalizationType = .none

        
        signInBtn = UIButton(type: .system)
        signInBtn.setTitle("SIGN IN", for: .normal)
        signInBtn.frame = CGRect(x: 100, y: 400, width: 100, height: 50)
        signInBtn.addTarget(self, action: #selector(login), for: UIControlEvents.touchUpInside)
        signInBtn.isEnabled = false
        
        view.addSubview(idTextField)
        view.addSubview(pwTextField)
        view.addSubview(signInBtn)
        // Do any additional setup after loading the view.
    }
    
    func login() {
        print("Sign In")
        let userCredentials = SyncCredentials.usernamePassword(username: idTextField.text!, password: pwTextField.text!, register: false)
        let serverURL = URL(string: "http://127.0.0.1:9080/")
        SyncUser.logIn(with: userCredentials, server: serverURL!) { user, error in
            if let user = user {
                // can now open a synchronized Realm with this user
                let defaults = UserDefaults.standard
                defaults.set(true, forKey:"isLogin")

                print(user)
                DispatchQueue.main.async {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Storyboard", bundle:nil)
                    let taskListVC = storyBoard.instantiateViewController(withIdentifier: "taskList") as! TaskListViewController
                    self.present(taskListVC, animated: true, completion: nil)
                }
//                print("IS LOGIN",defaults.object(forKey: "isLogin"))
            } else if let error = error {
                print(error)
            }
        }

    }
    
    func textFieldDidChange(textField: UITextField) {
        if !(idTextField.text?.isEmpty)! && !(pwTextField.text?.isEmpty)! {
            signInBtn.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
