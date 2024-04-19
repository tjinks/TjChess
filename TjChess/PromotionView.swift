//
//  PromotionView.swift
//  TjChess
//
//  Created by Tony on 18/04/2024.
//

import Cocoa
import ChessLib

class PromotionView: NSView {
    
    @IBAction func queenSelected(_ sender: Any) {
        promoteTo(.queen)
    }
    
    @IBAction func rookSelected(_ sender: Any) {
        promoteTo(.rook)
    }
    
    @IBAction func knightSelected(_ sender: Any) {
        promoteTo(.knight)
    }
    
    @IBAction func bishopSelected(_ sender: Any) {
        promoteTo(.bishop)
    }
    
    private func promoteTo(_ pieceType: ChessLib.PieceType) {
        getDispatcher().dispatch(GlobalEvent.promoteTo(piece: pieceType))
        self.window?.close()
    }
}
