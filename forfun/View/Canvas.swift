//
//  Canvas.swift
//  forfun
//
//  Created by WEN-HSUAN TUNG on 2021/7/21.
//

import UIKit


class Canvas: UIView {
    
    fileprivate var lines = [Line]()
    var canvasViewObject: ViewController?
    var color : CGColor = UIColor.black.cgColor
    var lineWidth : CGFloat = 1
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        

        lines.forEach { (line) in
            context.setStrokeColor(line.color)
            context.setLineWidth(line.lineWidth)
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
    
    func changeColor(color: CGColor){
        self.color = color
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(color: color, lineWidth: lineWidth, points: []))
        print("touchesBegan: \(lines)")
    }
    // track finger as move across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    
    func undostep(){
        _ = self.lines.popLast()
        setNeedsDisplay()
    }
    
    func clear(){
        lines.removeAll()
        setNeedsDisplay()
    }

    
}
