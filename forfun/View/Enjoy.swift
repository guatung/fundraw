//
//  Canvas.swift
//  forfun
//
//  Created by WEN-HSUAN TUNG on 2021/7/21.
//

import UIKit
import ReplayKit

class Enjoy: UIView {
    
    fileprivate var enjoyLines = [JoyLine]()
    var enjoyViewObject: EnjoyViewController?
    var lineColor : CGColor = UIColor.white.cgColor
    var shadowColor : CGColor = UIColor.white.cgColor
    var lineWidth : CGFloat = 7
    
    var colorList : [CGColor] = [UIColor.systemPink.cgColor,UIColor.systemOrange.cgColor,UIColor.systemYellow.cgColor,UIColor.systemGreen.cgColor,UIColor.systemBlue.cgColor,UIColor.systemPurple.cgColor,UIColor.white.cgColor]
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(UIColor.black.cgColor)
        context.fill(rect)
        
        
        enjoyLines.forEach { (line) in
            let index = Int.random(in: 0...colorList.count-1)
            let index2 = Int.random(in: 0...colorList.count-1)
            shadowColor = colorList[index]
            lineColor = colorList[index2]
            context.setStrokeColor(lineColor)
            context.setLineWidth(line.lineWidth)
            context.setShadow(offset: CGSize(width: 3, height: 3), blur: 8, color: shadowColor)
            
            
            
            context.setLineCap(.round)// allow round
            for (i, p) in line.points.enumerated(){
                if i == 0 {
                    context.move(to: p)
                }else{
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    func setLineWidth(float:CGFloat){
        self.lineWidth = float
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        enjoyLines.append(JoyLine.init(color: shadowColor, lineWidth: lineWidth, points: []))
    }
    // track finger as move across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = enjoyLines.popLast() else { return }
        lastLine.points.append(point)
        enjoyLines.append(lastLine)
        setNeedsDisplay()
    }
    
    
    func undo(){
        _ = self.enjoyLines.popLast()
        setNeedsDisplay()
        print("undo")
    }
    
    func clear(){
        enjoyLines.removeAll()
        setNeedsDisplay()
        print("clear enjoy")
    }
    
}
