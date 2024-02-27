//
//  BoardView.swift
//  AnotherUiProto
//
//  Created by Tony on 25/02/2024.
//

import Cocoa

class BoardView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let scale = getScale()
        if let ctx = NSGraphicsContext.current?.cgContext {
            ctx.saveGState()
            ctx.scaleBy(x: scale, y: scale)
            for rank in 0...7 {
                for file in 0...7 {
                    drawPiece(context: ctx, code: "WN", file: file, rank: rank)
                }
            }
            
            ctx.restoreGState()
        }
        
    }
    
    func installClickHandler() {
        let gr = NSClickGestureRecognizer(target: self, action: #selector(boardClicked))
        addGestureRecognizer(gr)
    }
    
    @objc func boardClicked(sender: NSClickGestureRecognizer) {
        print("Called!")
    }
    
    private func drawPiece(context: CGContext, code: String, file: Int, rank: Int) {
        let squareSize = BoardView.squareSize
        let x = Double(file) * (squareSize - 1)
        let y = Double(rank) * (squareSize - 1)
        let background = (file + rank) % 2 == 0 ? "B" : "W"
        if let image = BoardView.getImage(code + background) {
            context.draw(image, in: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: squareSize, height: squareSize)))
        }
        
    }
    
    private static func getImage(_ assetName: String) -> CGImage? {
        let image = NSImage(named: assetName)
        return image?.cgImage(forProposedRect: nil, context: nil, hints: nil)
    }
    
    private func getScale() -> Double {
        let squareSize = BoardView.squareSize
        let boardSize = 8 * (squareSize - 1) + 1
        let available = min(bounds.width, bounds.height)
        let result = available / boardSize
        return min(result, 1.5)
    }
    
    private static var squareSize: Double {
        get {
            let image = NSImage(named: "EW")
            return image!.size.width
        }
    }
}
