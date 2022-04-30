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
    
    // checks is x or y axis of the ball position with an offset of
    // the radius of the ball is within the bounds of the screen
    private func ballIsOOB() -> (xAxis: Bool, yAxis: Bool) {
        let xAxisOOB =  (ballPosition.x - ballRadius) <= 0 ||
                        (ballPosition.x + ballRadius >= bounds.width)
        let yAxisOOB =  (ballPosition.y - ballRadius <= 0) ||
                        (ballPosition.y - ballRadius >= bounds.width)
        return (xAxisOOB, yAxisOOB)
    }
    
    // checks if the ball has hit the paddle
    // xBounds and yBounds set the bounds of the paddle in a 2D plane
    // retValue is false if the ball has not hit the paddle
    private func ballHitPaddle() -> Bool {
        let xBounds = (lower: paddlePosition - paddleSize.width / 2,
                       upper: paddlePosition + paddleSize.width / 2)
        let yBounds = (lower: paddleBottomOffset - paddleSize.height / 2,
                       upper: paddleBottomOffset + paddleSize.height / 2)
        let retValue =  (ballPosition.x >= xBounds.lower) &&
                        (ballPosition.x <= xBounds.upper) &&
                        (ballPosition.y - ballRadius >= yBounds.lower) &&
                        (ballPosition.y - ballRadius <= yBounds.upper)
        return retValue
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
