//
//  ViewController.swift
//  forfun
//  Created by WEN-HSUAN TUNG on 2021/7/21.
//

import UIKit
import Combine

class ViewController: UIViewController, UIColorPickerViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var canvasObject : Canvas = Canvas()
    var canvasLines : [[CGPoint]] = [[CGPoint]]()
    @IBOutlet weak var canvasView: UIView!
    
    @IBOutlet weak var blackBtn: UIButton!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    
    @IBOutlet weak var pickColorBtn: UIButton!
    @IBOutlet weak var slider: UISlider!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        canvasObject.canvasViewObject = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canvasObject.translatesAutoresizingMaskIntoConstraints = false
        self.canvasView.addSubview(canvasObject)
        canvasObject.topAnchor.constraint(equalTo: self.canvasView.topAnchor).isActive = true
        canvasObject.rightAnchor.constraint(equalTo: self.canvasView.rightAnchor).isActive = true
        canvasObject.leftAnchor.constraint(equalTo: self.canvasView.leftAnchor).isActive = true
        canvasObject.bottomAnchor.constraint(equalTo: self.canvasView.bottomAnchor).isActive = true
        
        
        
    }
    @IBAction func undo(_ sender: Any) {
        canvasObject.undostep()
    }
    
    @IBAction func clear(_ sender: Any) {
        canvasObject.clear()
    }
    
    @IBAction func changeSlider(_ sender: Any) {
        canvasObject.setLineWidth(float: CGFloat(slider.value))
    }
    var cancellable: AnyCancellable?
    @IBAction func addColor(_ sender: Any) {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        
        colorPickerVC.isModalInPresentation = true
        present(colorPickerVC, animated: true)
        
        
        //  Subscribing selectedColor property changes.
        self.cancellable = colorPickerVC.publisher(for: \.selectedColor)
            .sink { color in
                
                //  Changing view color on main thread.
                DispatchQueue.main.async {
                    self.pickColorBtn.backgroundColor = color
                    self.canvasObject.changeColor(color:color.cgColor)
                }
            }
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.pickColorBtn.backgroundColor = color
       
    }
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.pickColorBtn.backgroundColor = color
    }
    
    @IBAction func changeBlack(button: UIButton) {
        canvasObject.changeColor(color: button.backgroundColor?.cgColor ?? UIColor.black.cgColor)
        //        canvasObject.changeColor(color: UIColor.black.cgColor)
    }
    
    @IBAction func changeRed(_ sender: Any) {
        canvasObject.changeColor(color:UIColor.red.cgColor)
        
    }
    
    @IBAction func changeBlue(_ sender: Any) {
        canvasObject.changeColor(color: UIColor.blue.cgColor)
    }

    @IBAction func photoPicker(_ sender: UIButton) {
        let image : UIImage = UIImage.init(view: self.canvasView)
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }
    
}

extension UIImage{
    convenience init(view: UIView) {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.init(cgImage: (image?.cgImage)!)

  }
}
