//
//  ViewController.swift
//  MemeMe_DT
//
//  Created by Daniel Tiemor on 11.06.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        topText.delegate = self
        bottomText.delegate = self
        topText.text = "TOP"
        topText.textAlignment = .center
        topText.layer.zPosition = 1
        bottomText.layer.zPosition = 1
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = .center
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        share.isEnabled = false


    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == topText {
            if textField.text == "TOP"{
        topText.text = ""
            }
        } else {
            if bottomText.text == "BOTTOM" {
            bottomText.text = ""
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == topText {
        self.topText.delegate = self
        topText.resignFirstResponder()

        } else {
        self.bottomText.delegate = self
        bottomText.resignFirstResponder()
        }

        return false
    }

    @IBOutlet weak var topText: UITextField!


    @IBOutlet weak var bottomText: UITextField!


    @IBAction func shareAction(_ sender: Any) {
        var imageShare: [Any] = []
        imageShare.append(generateMemedImage())

        let activityViewController = UIActivityViewController(activityItems: imageShare, applicationActivities: nil)

        present(activityViewController, animated: true, completion: nil)


        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if(success && error == nil){

                self.save()
                self.dismiss(animated: true, completion: nil);
            }
            else if (error != nil){
               print("error")
            }
        };

    }
    @IBAction func cancelAction(_ sender: Any) {
    }
    @IBAction func kameraAction(_ sender: Any) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func albumAction(_ sender: Any) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

        share.isEnabled = true

    }

    @IBOutlet weak var imagePickerView: UIImageView!

    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var kamera: UIBarButtonItem!
    @IBOutlet weak var album: UIBarButtonItem!



    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        }

        dismiss(animated: true, completion: nil)

    }

    /* func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        <#code#>
    }*/

    override func viewDidAppear(_ animated: Bool) {
        kamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -2.0

    ]


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }


    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification:Notification) {

        if bottomText.hasText == false {
        view.frame.origin.y -= getKeyboardHeight(notification)
        }

    }

    @objc func keyboardWillHide(_ notification:Notification) {
            view.frame.origin.y = 0
    }



    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setToolbarHidden(true, animated: false)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // TODO: Show toolbar and navbar
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.setToolbarHidden(false, animated: false)

        return memedImage
    }

    func save() {
        // Create the meme
        let creatememe = meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())

        print(creatememe)
    }


    struct meme {

            var topText: String
            var bottomText: String
            var originalImage: UIImage
            var memedImage: UIImage

    }

}


