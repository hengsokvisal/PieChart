//
//  ViewController.swift
//  PieChart
//
//  Created by Ken Phanith on 2018/05/23.
//  Copyright © 2018 Quad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pieChartView: PieChartView!
    
}


// MARK: - LIFECYCLE
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.pieChartView = PieChartView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 400))
        
        self.pieChartView.segments = [
            Segment(color: UIColor.red, name: "Red", value: 50),
            Segment(color: UIColor.blue, name: "Blue", value: 30),
            Segment(color: UIColor.brown, name: "Brown", value: 40),
            Segment(color: UIColor.green, name: "Green", value: 25)
        ]
        
        self.view.addSubview(pieChartView)
    }
    
}
