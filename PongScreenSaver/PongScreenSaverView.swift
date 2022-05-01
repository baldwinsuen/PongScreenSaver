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
    // TODO: improve logic for this
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
    
    // TODO: revisit tutorial, stopped reading code at step 4
    override func draw(_ rect: NSRect) {
        drawBackground(.white)
        drawBall()
        drawPaddle()
    }
    
    // TODO: read this
    private func drawBackground(_ color: NSColor) {
        let background = NSBezierPath(rect: bounds)
        color.setFill()
        background.fill()
    }
    
    // TODO: read this
    private func drawBall() {
        let ballRect = NSRect(x: ballPosition.x - ballRadius,
                              y: ballPosition.y - ballRadius,
                              width: ballRadius * 2,
                              height: ballRadius * 2)
        let ball = NSBezierPath(roundedRect: ballRect,
                                xRadius: ballRadius,
                                yRadius: ballRadius)
        NSColor.black.setFill()
        ball.fill()
    }
    
    // TODO: read this
    private func drawPaddle() {
        let paddleRect = NSRect(x: paddlePosition - paddleSize.width / 2,
                                y: paddleBottomOffset - paddleSize.height / 2,
                                width: paddleSize.width,
                                height: paddleSize.height)
        let paddle = NSBezierPath(rect: paddleRect)
        NSColor.black.setFill()
        paddle.fill()
    }
    
    override func animateOneFrame() {
        super.animateOneFrame()
        
        let oobAxes = ballIsOOB()
        if (oobAxes.xAxis) {
            // bounce off the verticals in the opposite direction
            ballVelocity.dx *= -1
        }
        if (oobAxes.yAxis) {
            // bounce off the horizontals in the opposite direction
            ballVelocity.dy *= -1
        }
        
        let paddleContact = ballHitPaddle()
        if (paddleContact) {
            // ??????
            // why are we changing the direction horizontally
            // what happens if this is not here
            ballVelocity.dy *= -1
        }
        
        ballPosition.x += ballVelocity.dx
        ballPosition.y += ballVelocity.dy
        // the paddle will always track the ball
        paddlePosition = ballPosition.x
        
        setNeedsDisplay(bounds)
    }
}
