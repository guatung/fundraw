//
//  HomeViewController.swift
//  forfun
//
//  Created by WEN-HSUAN TUNG on 2021/7/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var drawView: UIView!
    @IBOutlet weak var forFunView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageCornerRaduis(btn:self.drawView,shadowColor: UIColor.systemOrange.cgColor,borderWidth:5)
        setImageCornerRaduis(btn: self.forFunView,shadowColor: UIColor.systemGreen.cgColor,borderWidth:5)
        // Do any additional setup after loading the view.
    
    }
    
    @IBAction func goToDraw(_ sender: Any) {
        let page: ViewController = (self.storyboard?.instantiateViewController(withIdentifier: "DrawStoryboard"))! as! ViewController
        self.navigationController?.pushViewController(page, animated: true)
    }
    @IBAction func goToFun(_ sender: Any) {
        let page: EnjoyViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FunStoryboard"))! as! EnjoyViewController
        self.navigationController?.pushViewController(page, animated: true)
    }
    //
//    @IBAction func goToFun(_ sender: Any) {
//            let page: EnjoyViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FunStoryboard"))! as! EnjoyViewController
//            self.navigationController?.pushViewController(page, animated: true)
//    }
    func setImageCornerRaduis(btn:UIView,shadowColor:CGColor,borderWidth:Float){
        btn.layer.cornerRadius = 30.0
        btn.layer.borderWidth = CGFloat(borderWidth)
        btn.layer.borderColor = shadowColor
        btn.clipsToBounds = true
       
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
