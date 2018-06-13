//
//  ContactFriendListViewController.swift
//  LogIn
//
//  Created by Insharp on 3/23/17.
//  Copyright © 2017 Insharp. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import Alamofire
import SwiftyJSON
import KRProgressHUD
import AlamofireObjectMapper
import SwiftMessages
import ImageSlideshow
import AVFoundation
import Foundation

class EditProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate {
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var ChangeImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var companyAddress: UITextField!
    @IBOutlet weak var designation: UITextField!
    @IBOutlet weak var contact_1: UITextField!
    @IBOutlet weak var contact_2: UITextField!
    @IBOutlet weak var contact_3: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    var user: User!
    var Edit_Profile = [EditProfile]()
    var profile = [Profile]()
    var size : Int = 0
    var newUserImage: UIImage!
    var img : String!
    var UserImage: UIImage!
    var previousImage: UIImage!
    //var img: UIImage!
    var existingImage: UIImage!
    var ProfileResponse = [Profile]()
    var TabViewController: UIViewController!
    var SettingViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBackButton()
        self.loadUserData(afterUpdate: 0)
        let tapChangeImage = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.tapChangeImageFunction))
        ChangeImage.isUserInteractionEnabled = true
        ChangeImage.addGestureRecognizer(tapChangeImage)
        //ui format name
        name.leftViewMode = UITextFieldViewMode.always
        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray).cgColor
        border.frame = CGRect(x: 0, y: name.frame.size.height - width, width:  name.frame.size.width, height: name.frame.size.height)
        border.borderWidth = width
        name.layer.addSublayer(border)
        name.layer.masksToBounds = true
        name.attributedPlaceholder = NSAttributedString(string:"Enter Your Name", attributes:[NSForegroundColorAttributeName: UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray),NSFontAttributeName :UIFont(name: "Arial", size: 13)!])
        //ui format email
        email.leftViewMode = UITextFieldViewMode.always
        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray).cgColor
        border.frame = CGRect(x: 0, y: email.frame.size.height - width, width:  email.frame.size.width, height: email.frame.size.height)
        border.borderWidth = width
        email.layer.addSublayer(border)
        email.layer.masksToBounds = true
        email.attributedPlaceholder = NSAttributedString(string:"Enter Your Email", attributes:[NSForegroundColorAttributeName: UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray),NSFontAttributeName :UIFont(name: "Arial", size: 13)!])
        //ui format companyName
        companyName.leftViewMode = UITextFieldViewMode.always
        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray).cgColor
        border.frame = CGRect(x: 0, y: companyName.frame.size.height - width, width:  companyName.frame.size.width, height: companyName.frame.size.height)
        border.borderWidth = width
        companyName.layer.addSublayer(border)
        companyName.layer.masksToBounds = true
        companyName.attributedPlaceholder = NSAttributedString(string:"Enter Your Company Name", attributes:[NSForegroundColorAttributeName: UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray),NSFontAttributeName :UIFont(name: "Arial", size: 13)!])
        //ui format companyAddress
        companyAddress.leftViewMode = UITextFieldViewMode.always
        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray).cgColor
        border.frame = CGRect(x: 0, y: companyAddress.frame.size.height - width, width:  companyAddress.frame.size.width, height: companyAddress.frame.size.height)
        border.borderWidth = width
        companyAddress.layer.addSublayer(border)
        companyAddress.layer.masksToBounds = true
        companyAddress.attributedPlaceholder = NSAttributedString(string:"Enter Your Company Address", attributes:[NSForegroundColorAttributeName: UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray),NSFontAttributeName :UIFont(name: "Arial", size: 13)!])
        //ui format designation
        designation.leftViewMode = UITextFieldViewMode.always
        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray).cgColor
        border.frame = CGRect(x: 0, y: designation.frame.size.height - width, width:  designation.frame.size.width, height: designation.frame.size.height)
        border.borderWidth = width
        designation.layer.addSublayer(border)
        designation.layer.masksToBounds = true
        designation.attributedPlaceholder = NSAttributedString(string:"Enter Your Designation", attributes:[NSForegroundColorAttributeName: UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray),NSFontAttributeName :UIFont(name: "Arial", size: 13)!])
        //ui format contact_1
        contact_1.leftViewMode = UITextFieldViewMode.always
        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray).cgColor
        border.frame = CGRect(x: 0, y: contact_1.frame.size.height - width, width:  contact_1.frame.size.width, height: contact_1.frame.size.height)
        border.borderWidth = width
        contact_1.layer.addSublayer(border)
        contact_1.layer.masksToBounds = true
        contact_1.attributedPlaceholder = NSAttributedString(string:"Enter Your First Contact", attributes:[NSForegroundColorAttributeName: UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray),NSFontAttributeName :UIFont(name: "Arial", size: 13)!])
        //ui format contact_2
        contact_2.leftViewMode = UITextFieldViewMode.always
        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray).cgColor
        border.frame = CGRect(x: 0, y: contact_2.frame.size.height - width, width:  contact_2.frame.size.width, height: contact_2.frame.size.height)
        border.borderWidth = width
        contact_2.layer.addSublayer(border)
        contact_2.layer.masksToBounds = true
        contact_2.attributedPlaceholder = NSAttributedString(string:"Enter Your Second Contact", attributes:[NSForegroundColorAttributeName: UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray),NSFontAttributeName :UIFont(name: "Arial", size: 13)!])
        //ui format contact_3
        contact_3.leftViewMode = UITextFieldViewMode.always
        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray).cgColor
        border.frame = CGRect(x: 0, y: contact_3.frame.size.height - width, width:  contact_3.frame.size.width, height: contact_3.frame.size.height)
        border.borderWidth = width
        contact_3.layer.addSublayer(border)
        contact_3.layer.masksToBounds = true
        contact_3.attributedPlaceholder = NSAttributedString(string:"Enter Your Third Contact", attributes:[NSForegroundColorAttributeName: UIColor(Config.COLOR_TEXTFIELD_BACKGROUND_LIGHT_gray),NSFontAttributeName :UIFont(name: "Arial", size: 13)!])
    }
    func navigationBackButton(){
        self.navigationItem.title = "Update Profile"
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let backgroundColor = UIColor(red: 48.0/255.0, green: 198.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        self.navigationController!.navigationBar.barTintColor = backgroundColor
        let attrs = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attrs
        //let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(btnClicked_Left(_:)))
        //self.navigationItem.leftBarButtonItem = backButton
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(btnClicked_Right(_:)))
        self.navigationItem.rightBarButtonItem = back

        let signOut = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(btnClicked_Right(_:)))
        self.navigationItem.rightBarButtonItem = signOut
    }
    func btnClicked_Left(_ sender: UIBarButtonItem) {
        _=navigationController?.popViewController(animated: true)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let SettingViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
//        self.SettingViewController = UINavigationController(rootViewController: SettingViewController)
//        self.navigationController?.pushViewController(SettingViewController, animated: true)
       // self.present(self.SettingViewController, animated: true, completion: nil)
    }
    func btnClicked_Right(_ sender: UIBarButtonItem)  {
        let alertController = UIAlertController(title: "Confirmation", message: "Are you sure that you want to sign out?", preferredStyle: UIAlertControllerStyle.alert)
        let signOutButton = UIAlertAction(title: "Sign out", style: .default, handler: { (action) -> Void in
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "userid")
            userDefaults.removeObject(forKey: "name")
            userDefaults.synchronize()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
            self.present(loginViewController, animated: true, completion: nil)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(signOutButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func signOut(_ sender: Any) {
    let alertController = UIAlertController(title: "Confirmation", message: "Are you sure that you want to sign out?", preferredStyle: UIAlertControllerStyle.alert)
    let signOutButton = UIAlertAction(title: "Sign out", style: .default, handler: { (action) -> Void in
    let userDefaults = UserDefaults.standard
    userDefaults.removeObject(forKey: "userid")
    userDefaults.removeObject(forKey: "name")
    userDefaults.synchronize()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
    self.present(loginViewController, animated: true, completion: nil)
    })
    let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alertController.addAction(signOutButton)
    alertController.addAction(cancelButton)
    self.present(alertController, animated: true, completion: nil)
    }

    func tapChangeImageFunction(_ sender: UIGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            picker.sourceType = .camera
            picker.allowsEditing = false
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let User_Image = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: nil)
        self.companyLogo.image = User_Image
        UserImage =  self.companyLogo.image!
}
    func updateUser(){
        KRProgressHUD.show()
        let defaults = UserDefaults.standard
        let user_id = defaults.object(forKey: "id") as? Int
        guard let name = name.text , !name.isEmpty else {
            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: "Name is required.")
            return
        }
        guard let email = email.text , !email.isEmpty else {
            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: "Email is required.")
            return
        }
        guard let companyName = companyName.text , !companyName.isEmpty else {
            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: "Company Name is required.")
            return
        }
        guard let companyAddress = companyAddress.text , !companyAddress.isEmpty else {
            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: "Company Address is required.")
            return
        }
        guard let designation = designation.text , !designation.isEmpty else {
            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: "Designation is required.")
            return
        }
        guard let contact_1 = contact_1.text , !contact_1.isEmpty else {
            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: "contact no is required.")
            return
        }
        if (UserImage == nil){
            UserImage = previousImage
            //Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: "Please update profile image")
            //return
        }
//        else {
//        
//        }
        img = Functions.convertImageToBase64(image: UserImage)
        guard let contact_2 = contact_2.text else {return}
        guard let contact_3 = contact_3.text else {return}
       
       let phoneNo = [contact_1, contact_2, contact_3]
       let parametersEdit: Parameters = [
            "name": name,
            "designation": designation,
            "email": email,
            "corperation_name": companyName,
            "corperation_address": companyAddress,
            "profile_image": img,
            "phone_no": phoneNo,
            "registration_id": user_id! ,
        ]
        Alamofire.request(Router.editUser(parameters: parametersEdit))
            .validate()
            .responseObject { (response: DataResponse<ProfileResponse>) in
                KRProgressHUD.dismiss()
                switch response.result {
                case .success:
                    let userResponse = response.result.value
                    let code = userResponse!.meta!.code!
                    switch(code){
                    case 1504, 1503:
                        Functions.showResponseErrorMessage(code: code)
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! LoginPageViewController
                        self.present(loginViewController, animated: true, completion: nil)
                        return
                    case 1501, 1500, 500:
                        Functions.showResponseErrorMessage(code: code)
                        return
                    case 1000:
                        var message = ""
                        if !(userResponse!.errors?.corperation?.img == nil) {
                            message = String((userResponse!.errors?.corperation?.img)!)!
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }else if !(userResponse!.errors?.name == nil) {
                            message = (userResponse!.errors?.name)!
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }else if !(userResponse!.errors?.email == nil) {
                            message = (userResponse!.errors?.email)!
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }
                        else if !(userResponse!.errors?.designation == nil) {
                            message = (userResponse!.errors?.designation)!
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }else if !(userResponse!.errors?.corperation?.companyName == nil) {
                            message = (userResponse!.errors?.corperation?.companyName)!
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }else if !(userResponse!.errors?.corperation?.companyAddress == nil) {
                            message = (userResponse!.errors?.corperation?.companyAddress)!
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }else if !(userResponse!.errors?.phones?[0].phoneNo == nil) {
                            message = ("Error With your phone no")
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }else if !(userResponse!.errors?.user_id == nil) {
                            message = ("Error with your registration Id")
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }
                        else {
                            message = (userResponse!.meta?.message)!
                            Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        }
                        Functions.showMessage(type: Functions.ErrorMessage, title: "Error", message: message)
                        return
                    case 200:
                        Functions.showMessage(type: Functions.SuccessMessage, title: "Success", message: "Profile details updated successfully.")
                        let alertController = UIAlertController(title: "Alert", message: "Do you need to go profile view?", preferredStyle: UIAlertControllerStyle.alert)
                        let goToProfile = UIAlertAction(title: "Yes, Go", style: .default, handler: { (action) -> Void in
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let SettingViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
                            self.SettingViewController = UINavigationController(rootViewController: SettingViewController)
                            self.navigationController?.pushViewController(SettingViewController, animated: true)
                        })
                        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                        alertController.addAction(goToProfile)
                        alertController.addAction(cancelButton)
                        self.present(alertController, animated: true, completion: nil)
                    default:
                        Functions.showMessage(type:Functions.ErrorMessage, title: "Error", message: "Something went wrong, Please try again later.")
                    }
                case .failure(_):
                    KRProgressHUD.dismiss()
                    if response.result.error != nil {
                        Functions.showMessage(type:Functions.ErrorMessage, title: "Sorry", message: (response.result.error?.localizedDescription)!)
                    }
                }
        }
    }
    
@IBAction func saveData(_ sender: Any) {
      self.updateUser()
    }
    func loadUserData(afterUpdate: Int) {
     let defaults = UserDefaults.standard
     let user_id = defaults.object(forKey: "id") as? Int
     let phoneNo = ["contact_1", "contact_2", "contact_3"]
        KRProgressHUD.show()
        Alamofire.request(Router.getUser(user_id: user_id!))
            .validate()
            .responseObject { (response: DataResponse<ProfileResponse>) in
                KRProgressHUD.dismiss()
                switch response.result {
                case .success:
                     let ProfileResponse = response.result.value
                     let code = ProfileResponse!.meta!.code!
                    switch(code){
                    case 1504, 1503, 500, 404:
                        Functions.showResponseErrorMessage(code: code)
                        return
                    case 200:
                        self.profile.append((ProfileResponse?.Profile)!)
                        let profileDetails  = self.profile[0]
                        self.name.text = profileDetails.name
                        self.email.text = profileDetails.email
                        self.designation.text = profileDetails.designation
                        self.companyName.text = profileDetails.corperation?.companyName
                        self.companyAddress.text = profileDetails.corperation?.companyAddress
                        self.size = (profileDetails.phones?.count)!
                        switch(self.size){
                        case 1:
                            let iString:Int = (profileDetails.phones?[0].phoneNo)!
                            let strString1 = String(iString)                            
                            self.contact_1.text = strString1
                            break
                        case 2:
                            let iString1:Int = (profileDetails.phones?[0].phoneNo)!
                            let iString2:Int = (profileDetails.phones?[1].phoneNo)!
                            let strString1 = String(iString1)
                            let strString2 = String(iString2)
                            self.contact_1.text = strString1
                            self.contact_2.text = strString2
                            break
                        case 3:
                            let iString1:Int = (profileDetails.phones?[0].phoneNo)!
                            let iString2:Int = (profileDetails.phones?[1].phoneNo)!
                            let iString3:Int = (profileDetails.phones?[2].phoneNo)!
                            let strString1 = String(iString1)
                            let strString2 = String(iString2)
                            let strString3 = String(iString3)
                            self.contact_1.text = strString1
                            self.contact_2.text = strString2
                            self.contact_3.text = strString3
                            break
                        default:
                            Functions.showMessage(type:Functions.ErrorMessage, title: "Error", message: "Something went wrong with phone contacts, Please try again later.")
                        }
                        let url = URL(string: (profileDetails.corperation?.img)! + "?av")
                        let task = URLSession.shared.dataTask(with: url!) { (responseData, responseUrl, error) -> Void in
                            if let data = responseData{
                                DispatchQueue.main.async(execute: { () -> Void in
                                    self.companyLogo.image = UIImage(data: data)
                                    self.previousImage = self.companyLogo.image
                                    
                                  })
                            }
                        }
                        task.resume()
                        if(afterUpdate == 1) {
                            let defaults = UserDefaults.standard
                            defaults.set(self.user.name, forKey: "name")
                            defaults.set(self.user.email, forKey: "email")
                           }
                    default:
                        Functions.showMessage(type:Functions.ErrorMessage, title: "Error", message: "Something went wrong, Please try again later.")
                    }default:
                        Functions.showMessage(type:Functions.ErrorMessage, title: "Error", message: "Something went wrong, Please try again later.")
                }
        }
    }
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()    }
}
