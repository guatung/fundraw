//
//  EnjoyViewController.swift
//  forfun
//
//  Created by WEN-HSUAN TUNG on 2021/7/23.
//

import UIKit
import ReplayKit

class EnjoyViewController: UIViewController {
    var enjoyObject : Enjoy = Enjoy()
    var enjoyLines : [[CGPoint]] = [[CGPoint]]()
    @IBOutlet weak var enjoyView: UIView!
    
    let recorder = RPScreenRecorder.shared()
    
    
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var recordStatusLabel: UILabel!
    
    var recordIsActive : Bool = false
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        enjoyObject.enjoyViewObject = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enjoyObject.translatesAutoresizingMaskIntoConstraints = false
        self.enjoyView.addSubview(enjoyObject)
        enjoyObject.topAnchor.constraint(equalTo: self.enjoyView.topAnchor).isActive = true
        enjoyObject.rightAnchor.constraint(equalTo: self.enjoyView.rightAnchor).isActive = true
        enjoyObject.leftAnchor.constraint(equalTo: self.enjoyView.leftAnchor).isActive = true
        enjoyObject.bottomAnchor.constraint(equalTo: self.enjoyView.bottomAnchor).isActive = true
    }
    @IBAction func undo(_ sender: Any) {
        enjoyObject.undo()
    }
    @IBAction func clear(_ sender: Any) {
        enjoyObject.clear()
    }
    
    @IBAction func back(_ sender: Any) {
            self.navigationController?.popToRootViewController(animated: true)
    }
       
    // MARK: phtot
    @IBAction func photoPicker(_ sender: UIButton) {
        let image : UIImage = UIImage.init(view: self.enjoyView)
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }

    // MARK: record
    func setRecordingState(active:Bool){
        var color : UIColor = UIColor.systemPink
        DispatchQueue.main.async {
            if active == true {
                color = UIColor.systemPink
                self.recordBtn.backgroundColor = .black
                self.recordBtn.layer.borderWidth = 1
                self.recordStatusLabel.textColor = color
                self.recordBtn.layer.shadowColor = color.cgColor
                self.recordStatusLabel.text = "Stop"
                self.recordBtn.layer.shadowOpacity = 0.5
                
            }else{
                let color = UIColor.init(named: "75FFCF")
                self.recordBtn.backgroundColor = color
                self.recordBtn.layer.borderWidth = 0
                self.recordStatusLabel.textColor = .black
                self.recordStatusLabel.text = "Record"
                self.recordBtn.layer.shadowOpacity = 0
                
            }
            self.recordBtn.layer.borderColor = color.cgColor
            self.recordBtn.layer.cornerRadius = 20
            self.recordBtn.layer.masksToBounds = false
            self.recordBtn.layer.shadowRadius = 30
            
            self.recordBtn.layer.shadowOffset =  CGSize(width: 0, height: 0)
            self.recordIsActive = active
        }
    }
    @IBAction func onRecordTapped(_ sender: Any) {
        if recordIsActive == false {
            recorder.startRecording { (error) in
                if let e = error {
                    print("record error  \(e)")
                    self.setRecordingState(active:false)
                    return
                }
                self.setRecordingState(active:true)
                print("recording")
            }
        }else{
            recorder.stopRecording { (previewVC, error) in
                if let e = error {
                    print("record error  \(e)")
                    return
                }
                if let previewVC = previewVC {
                    previewVC.previewControllerDelegate = self
                    self.present(previewVC, animated: true, completion: nil)
                    self.setRecordingState(active:false)
                    print("stop recording")
                }
            }
        }
    }

}


extension EnjoyViewController: RPPreviewViewControllerDelegate{
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}

