//
//  ViewController.swift
//  MemeMe_DT
//
//  Created by Daniel Tiemor on 11.06.19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        topText.text = "TOP"
        topText.textAlignment = .center
        topText.layer.zPosition = 1
        bottomText.layer.zPosition = 1
        bottomText.text = "BOTTOM"
        bottomText.textAlignment = .center
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
      

    }


    @IBOutlet weak var topText: UITextField!

    @IBAction func topTextAction(_ sender: Any) {
    }

    @IBOutlet weak var bottomText: UITextField!

    @IBAction func bottomTextAction(_ sender: Any) {
    }

    @IBAction func shareAction(_ sender: Any) {
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
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification:Notification) {

        view.frame.origin.y -= getKeyboardHeight(notification)
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

}

