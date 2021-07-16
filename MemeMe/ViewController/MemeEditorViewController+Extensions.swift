//
//  MemeEditorViewController+Extensions.swift
//  MemeMe
//
//  Created by Sophia Lu on 7/15/21.
//

import Foundation
import UIKit


// MARK - Image picker delegate

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                  imagePickerView.image = image
              }
        
        if imagePickerView.image != nil {
            shareButton.isEnabled = true
            guideLabel.isHidden = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK - Text editor delegate

extension MemeEditorViewController: UITextFieldDelegate {
    
   
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.text = ""
        }
       
        // Move the screen for keyboard hiding
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
             
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        keyboardWillHide()
        
        return false
    }

    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder && view.frame.origin.y == 0.0 {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
    }
    
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
    
    // Hide Keyboard by touching Anywhere outside UITextField iOS
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
