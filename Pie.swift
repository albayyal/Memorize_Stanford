//
//  Pie.swift
//  Memorize_Stanford
//
//  Created by Laith Al Bayya on 01.07.22.
//

import SwiftUI

struct Pie: Shape {
    var startAngel: Angle
    var endAngel: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint (
            x: center.x + radius * cos(startAngel.radians),
            y: center.y + radius * sin(startAngel.radians)
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngel,
            endAngle: endAngel,
            clockwise: !clockwise
        )
        p.addLine(to: center)
        return p
    }
}
