//
//  StartViewController.swift
//  BeyondWunder
//
//  Created by hoemoon on 07/02/2017.
//  Copyright © 2017 hoemoon. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
        
    }
    
    func setUpView() {
        view.backgroundColor = UIColor.white
        
        let signUpButton = UIButton(type: .system)
        signUpButton.frame = CGRect(x: 85, y: 350, width: 150, height: 30)
        signUpButton.setTitle("CREATE ACCOUNT", for: .normal)
        signUpButton.addTarget(self, action: #selector(goSignup), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        let loginButton = UIButton(type: .system)
        loginButton.frame = CGRect(x: 110, y: 390, width: 100, height: 30)
        loginButton.setTitle("SIGN IN", for: .normal)
        loginButton.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goSignup() {
        let signupVC = SignupViewController()
        //let navigationVC = UINavigationController(rootViewController: taskListVC)
//        present(navigationVC, animated: true, completion: nil)
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    func goLogin() {
        let loginVC = LoginViewController()
        //let navigationVC = UINavigationController(rootViewController: taskListVC)
        //        present(navigationVC, animated: true, completion: nil)
        navigationController?.pushViewController(loginVC, animated: true)
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
