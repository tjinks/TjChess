//
//  AppDelegate.swift
//  TjChess
//
//  Created by Tony on 26/02/2024.
//

import Cocoa
import ChessBE

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let dispatcher = EventDispatcher()
    
    @IBAction func computerPlaysWhite(_ sender: Any) {
        let gameStateDto = try! Notation.parseFen(fen: "k1K5/8/8/8/8/8/8/8 w");
        dispatcher.dispatch(GlobalEvent.showGameState(state: gameStateDto))
    }
    
    @IBAction func computerPlaysBlack(_ sender: Any) {
    }
    
    @IBAction func computerPlaysItself(_ sender: Any) {
    }
    
    
    @IBAction func enterMoves(_ sender: Any) {
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _ = GameController(dispatcher: dispatcher)
        //dispatcher.dispatch(SetGameState(fen: Notation.initialPosition))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        dispatcher.dispatch(GlobalEvent.shutdownInProgress)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}


func getDispatcher() -> EventDispatcher {
    let app = NSApplication.shared.delegate as! AppDelegate
    return app.dispatcher
}

