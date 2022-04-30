//
//  PongScreenSaverView.swift
//  PongScreenSaver
//
//  Created by Baldwin Suen on 4/30/22.
//

import ScreenSaver

class PongScreenSaverView: ScreenSaverView {
    
    private var ballPosition: CGPoint = .zero
    private var ballVelocity: CGVector = .zero
    private var paddlePosition: CGFloat = 0
    private let ballRadius: CGFloat = 15
    private let paddleBottomOffset: CGFloat = 100
    private let paddleSize = NSSize(width: 60, height: 20)
    
    // step: intializing
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        // initial ball position is in center of screen
        ballPositon = CGPoint(x: frame.width / 2, y: frame/height / 2)
        
        // initial ball velocity set to a random vector with magnitude 10
        ballVelocity = initialVelocity()
    }
    
    // sets initial velocity of ball when object is instantiated
    private func initialVelocity() -> CGVector {
        let desiredVelocityMagnitude: CGFloat = 10
        let xVelocity = CGFloat.random(in: 2.5...7.5)
        let xSign: CGFloat = Bool.random() ? 1 : -1
        // √(100 - xVelocity^2)
        let yVelocity = sqrt(pow(desiredVelocityMagnitude, 2) - pow(xVelocity, 2))
        let ySign: CGFloat = Bool.random() ? 1 : -1
        return CGVector(dx: xVelocity * xSign, dy: yVelocity * ySign)
    }
    
    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // step: lifecycle
    
    override func draw(_rect: NSRect) {
        // draw single frame in this function
    }
    
    override func animateOneFrame() {
        super.animateOneFrame()
        
        // update the "state" of the screensaver with this function
    }
}
