//
//  BoardView.swift
//  AnotherUiProto
//
//  Created by Tony on 25/02/2024.
//

import Cocoa

class BoardView: NSView {
    private var _position: Position = Position()
    private var _highlights: [Square] = []
    
    var position: Position {
        get {
            return _position
        }
        
        set(value) {
            _position = value
            setNeedsDisplay(bounds)
        }
    }
    
    var highlights: [Square] {
        get {
            return _highlights
        }
        
        set(value) {
            _highlights = value
            setNeedsDisplay(bounds)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let scale = getScale()
        if let ctx = NSGraphicsContext.current?.cgContext {
            ctx.saveGState()
            ctx.scaleBy(x: scale, y: scale)
            for rank in 0...7 {
                for file in 0...7 {
                    drawPiece(context: ctx, square: try! Square(file: file, rank: rank))
                }
            }
            
            ctx.restoreGState()
        }
    }
    
    func installClickHandler() {
        let gr = NSClickGestureRecognizer(target: self, action: #selector(boardClicked))
        addGestureRecognizer(gr)
    }
    
    @objc private func boardClicked(sender: NSClickGestureRecognizer) {
        print("Called!")
    }
    
    private func drawPiece(context: CGContext, square: Square) {
        let squareSize = BoardView.squareSize
        let x = Double(square.file) * (squareSize - 1)
        let y = Double(square.rank) * (squareSize - 1)
        var assetName = getAssetName(for: position.getPiece(at: square), on: square)
        if highlights.contains(square) {
            assetName = assetName + "H"
        }
        
        if let image = BoardView.getImage(assetName) {
            context.draw(image, in: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: squareSize, height: squareSize)))
        }
    }
    
    private func getAssetName(for piece: Piece, on square: Square) -> String {
        let squareColour = (square.rank + square.file) % 2 == 0 ? "B" : "W"
        return {
            switch piece {
            case .king(let owner):
                return playerColour(owner) + "K"
            case .queen(let owner):
                return playerColour(owner) + "Q"
            case .rook(let owner):
                return playerColour(owner) + "R"
            case .bishop(let owner):
                return playerColour(owner) + "B"
            case .knight(let owner):
                return playerColour(owner) + "N"
            case .pawn(let owner):
                return playerColour(owner) + "P"
            case .none:
                return "E"
            }
        }() + squareColour
        
        func playerColour(_ player: Player) -> String {
            switch player {
            case .white: return "W"
            case .black: return "B"
            }
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
