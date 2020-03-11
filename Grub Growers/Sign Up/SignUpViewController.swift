//
//  SignUpViewController.swift
//  Grub Growers
//
//  Created by Nadia Goodlet on 10/03/2020.
//  Copyright © 2020 Nadia Goodlet. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    

    
    
    func setUpElements() {
        
        //Hide the error label 
        errorLabel.alpha = 0
        
   
        
        // Rounded corners on Sign Up button
        let path = UIBezierPath(roundedRect: self.signUpButton.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
           let maskLayer = CAShapeLayer()
           maskLayer.frame = self.signUpButton.bounds
           maskLayer.path = path.cgPath
           self.signUpButton.layer.mask = maskLayer
       
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
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Whoops! You missed something."
        }
        
        // Check password is secure
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if SignUpViewController.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            
            return "Passwords must contain at least 8 characters, a special character and a number."
        }
        
        // Check email is secure
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if SignUpViewController.isValidEmail(cleanedEmail) == false {
            
            return "Whoops! That email address is invalid."
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // Issue with fields, Show error message
            showError(error!)
        }
        else {
            
            //Clean the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // Create the user
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
               
                // Check for errors
                if err != nil {
                    
                    // Error occurred creating the user
                    self.showError("Sorry, an error has occurred whilst creating this account.")
                }
                else {
                    
                    // User successfully created, store first and last name
                  
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message, account was created but first and last name weren't saved
                            self.showError("Sorry, there was a server side error.")
                            
                        }
                    }
                    
                    // Transition to the Home screen
                    self.transitionToHome()
                    
                }
            }
            
        }
        
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func transitionToHome() {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
        
        
        
    }
    
}
