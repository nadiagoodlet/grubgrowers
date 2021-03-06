//
//  LoginViewController.swift
//  Grub Growers
//
//  Created by Nadia Goodlet on 10/03/2020.
//  Copyright © 2020 Nadia Goodlet. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
        
//        setupUI()
        
    }
    
  


    func setUpElements() {
        
        //Hide the error label
        errorLabel.alpha = 0
        
        
        // Rounded corners on Sign Up button
        let path = UIBezierPath(roundedRect: self.loginButton.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
           let maskLayer = CAShapeLayer()
           maskLayer.frame = self.loginButton.bounds
           maskLayer.path = path.cgPath
           self.loginButton.layer.mask = maskLayer
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
          
          let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
          return passwordTest.evaluate(with: password)
      }
      
     static func isValidEmail(_ email : String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

          let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailPred.evaluate(with: email)
      }
  
    // Check the fields and validate the data If correct return nil, else display error message
      func validateFields() -> String? {
          
          // Check all fields are filled
          
          if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
              
              return "Whoops! You missed something."
          }
          
          // Check password is secure
          
          let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
          if SignUpViewController.isPasswordValid(cleanedPassword) == false {
              // Password isn't secure enough
              
              return "Whoops! That password is incorrect."
          }
          
          // Check email is secure
          
          let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          
          if SignUpViewController.isValidEmail(cleanedEmail) == false {
              
              return "Whoops! That email address is invalid."
          }
          
          return nil
      }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Validate text fields
       
              let error = validateFields()
              
              if error != nil {
                  
                  // Issue with fields, Show error message
                  showError(error!)
              }
              else {
        
                // Clean data
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Sign in the user
                Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                    
                    if err != nil {
                        // Unsuccessful sign in
                        self.errorLabel.text = err!.localizedDescription
                        self.errorLabel.alpha = 1
                    }
                    else {
                        
                        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UITabBarController
                              
                        self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                              
                        
                    }
                }
    }
}
        
        func showError(_ message:String) {
               
               errorLabel.text = message
               errorLabel.alpha = 1
               
           }
    
}
