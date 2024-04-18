//
//  BoardView.swift
//  AnotherUiProto
//
//  Created by Tony on 25/02/2024.
//

import Cocoa

class BoardView: NSView {
    
    private var gameState = GameStateDto()
    private var highlights: [Int] = []
    private let dispatcher = getDispatcher()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        dispatcher.register(processEvent)
    }
    
    func processEvent(_ event: Any) {
        if let event = event as? GlobalEvent {
            switch event {
            case .showGameState(let state):
                setGameState(state)
            case .showHighlights(let highlights):
                self.highlights = highlights
                setNeedsDisplay(self.bounds)
            default:
                break
            }
        }
    }

    func setGameState(_ dto: GameStateDto) {
        gameState = dto
        highlights = []
        setNeedsDisplay(self.bounds)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        let scale = getScale()
        if let ctx = NSGraphicsContext.current?.cgContext {
            ctx.saveGState()
            ctx.scaleBy(x: scale, y: scale)
            try! forAllSquares() {
                drawPiece(context: ctx, square: $0)
                return true
            }
            
            ctx.restoreGState()
        }
    }
    
    func installClickHandler() {
        let gr = NSClickGestureRecognizer(target: self, action: #selector(boardClicked))
        addGestureRecognizer(gr)
    }
    
    @objc private func boardClicked(sender: NSClickGestureRecognizer) {
        let whereClicked = sender.location(in: self)
        if let square = pointToSquare(whereClicked) {
            dispatcher.dispatch(GlobalEvent.squareClicked(square: square))
        }
    }
    
    private func pointToSquare(_ point: NSPoint) -> Int? {
        let squareSize = BoardView.squareSize
        let scale = getScale()
        var result: Int? = nil
        try! forAllSquares() {
            let squareLocation = BoardView.squareToPoint($0)
            let dx = (point.x - squareLocation.x) / scale
            let dy = (point.y - squareLocation.y) / scale
            if dx > 0.0 && dx < squareSize {
                if dy > 0.0 && dy < squareSize {
                    result = $0
                    return false
                }
            }
            
            return true
        }
        
        return result
    }
    
    private static func squareToPoint(_ square: Int) -> CGPoint {
        let squareSize = BoardView.squareSize
        let x = Double(square.file) * (squareSize - 1)
        let y = Double(square.rank) * (squareSize - 1)
        return CGPoint(x: x, y: y)
    }
    
    private func drawPiece(context: CGContext, square: Int) {
        let squareSize = BoardView.squareSize
        let location = BoardView.squareToPoint(square)
        var assetName = getAssetName(for: gameState.board[square], on: square)
        if highlights.contains(square) {
            assetName = assetName + "H"
        }
        
        if let image = BoardView.getImage(assetName) {
            context.draw(image, in: CGRect(origin: location, size: CGSize(width: squareSize, height: squareSize)))
        }
    }
    
    private func getAssetName(for piece: Piece, on square: Int) -> String {
        let squareColour = (square.rank + square.file) % 2 == 0 ? "B" : "W"
        return {
            let owner = piece.owner
            let type = piece.type
            switch type {
            case .king:
                return playerColour(owner!) + "K"
            case .queen:
                return playerColour(owner!) + "Q"
            case .rook:
                return playerColour(owner!) + "R"
            case .bishop:
                return playerColour(owner!) + "B"
            case .knight:
                return playerColour(owner!) + "N"
            case .pawn:
                return playerColour(owner!) + "P"
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
        /*
        let squareSize = BoardView.squareSize
        let boardSize = 8 * (squareSize - 1) + 1
        let available = min(bounds.width, bounds.height)
        let result = available / boardSize
        return min(result, 1.5)
         */
        
        return 1.0
    }
    
    private static var squareSize: Double {
        get {
            let image = NSImage(named: "EW")
            return image!.size.width
        }
    }
}
