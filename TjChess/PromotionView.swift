//
//  PromotionView.swift
//  TjChess
//
//  Created by Tony on 18/04/2024.
//

import Cocoa
import ChessBE

class PromotionView: NSView {
    
    @IBAction func queenSelected(_ sender: Any) {
        promoteTo(ChessBE.Queen)
    }
    
    @IBAction func rookSelected(_ sender: Any) {
        promoteTo(ChessBE.Rook)
    }
    
    @IBAction func knightSelected(_ sender: Any) {
        promoteTo(ChessBE.Knight)
    }
    
    @IBAction func bishopSelected(_ sender: Any) {
        promoteTo(ChessBE.Bishop)
    }
    
    private func promoteTo(_ pieceType: ChessBE.EngPieceType) {
        getDispatcher().dispatch(GlobalEvent.promoteTo(piece: pieceType))
        self.window?.close()
    }
}
