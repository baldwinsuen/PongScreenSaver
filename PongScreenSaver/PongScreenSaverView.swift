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
