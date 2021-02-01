//
//  ViewController.swift
//  Instagrid
//
//  Created by chaleroux on 06/01/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var isActive: Bool = false
    
    @IBOutlet weak var dispositionOneButton: UIButton!
    @IBOutlet weak var dispositionTwoButton: UIButton!
    @IBOutlet weak var dispositionThreeButton: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    

    @IBOutlet weak var dispositionOneImage: UIImageView!
    @IBOutlet weak var dispositionTwoImage: UIImageView!
    @IBOutlet weak var dispositionThreeImage: UIImageView!
    
    @IBOutlet weak var squareView: UIView!
    
    var buttonImage: UIButton?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
    }
    
    enum Style {
        case topRectangle, fourSquares, bottomRectangle
    }
    
    var style: Style = .fourSquares {
        didSet {
            setStyle(style)
        }
    }
    
    private func setStyle(_ style: Style) {
        switch style {
        case .topRectangle:
           
            button1.isHidden = true
            button3.isHidden = false
            dispositionOneImage.isHidden = false
            dispositionTwoImage.isHidden = true
            dispositionThreeImage.isHidden = true
            
        case .fourSquares:
            
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            
            dispositionOneImage.isHidden = true
            dispositionTwoImage.isHidden = false
            dispositionThreeImage.isHidden = true

        case .bottomRectangle:
            
            button1.isHidden = false
            button3.isHidden = true
            dispositionOneImage.isHidden = true
            dispositionTwoImage.isHidden = true
            dispositionThreeImage.isHidden = false
       
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.buttonImage?.setImage(image, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    func animation() {
        if UIDevice.current.orientation.isPortrait {
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.squareView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            })
        }
        if UIDevice.current.orientation.isLandscape {
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.squareView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            })
        }
    }
    
    func animationBack() {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.squareView.transform = .identity
        })
    }
    //fgbvc
    func convert(_ view: UIView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: (image?.cgImage)!)
    }
    
    
    
    @IBAction func dispositionOneButton(_ sender: UIButton) {
        style = .topRectangle
    }
    @IBAction func dispositionTwoButton(_ sender: UIButton) {
        style = .fourSquares
    }
    @IBAction func dispositionThreeButton(_ sender: UIButton) {
        style = .bottomRectangle
        
    }
    
    @IBAction func didTapLibraryButton(_ sender: UIButton) {
        buttonImage = sender
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.allowsEditing = true
        image.delegate = self
        present(image, animated: true, completion: nil)
        }
    }
    
    @IBAction func share(_ sender: UISwipeGestureRecognizer) {
        animation()
        switch sender.direction {
        case .up:
            if UIDevice.current.orientation.isPortrait {
                let imageToShare = convert(squareView)
                let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
                activityVC.completionWithItemsHandler = {(activityVC, completed, returnedItem, error) in
                    self.animationBack()
                }
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC, animated: true, completion: nil) }
        case .left:
            if UIDevice.current.orientation.isLandscape {
                let imageToShare = convert(squareView)
                let activityVC = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
                activityVC.completionWithItemsHandler = {(activityVC, completed, returnedItem, error) in
                    self.animationBack()
                }
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC, animated: true, completion: nil) }
        default:
            break
        }
    }
}

