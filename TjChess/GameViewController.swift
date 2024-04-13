//
//  ViewController.swift
//  TjChess
//
//  Created by Tony on 26/02/2024.
//

import Cocoa

class GameViewController: NSViewController, EventHandler {
    private let dispatcher: EventDispatcher
    
    required init?(coder: NSCoder) {
        dispatcher = getDispatcher()
        super.init(coder: coder)
        dispatcher.register(self)
    }
    
    func processEvent(_ event: Any) {
        if let uiEvent = event as? UiEvent {
            switch uiEvent {
            case .showError(let message):
                let alert = NSAlert()
                alert.messageText = message
                alert.alertStyle = .warning
                alert.runModal()
            default:
                return
            }
        }
    }
    
    @IBOutlet private weak var boardView: BoardView?
        
    @IBOutlet private weak var fenEdit: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boardView!.installClickHandler()
        fenEdit.stringValue = Notation.initialPosition
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func startGameClicked(_ sender: Any) {
        humanVsHumanClicked(sender)
    }
    
    @IBAction func humanVsHumanClicked(_ sender: Any) {
        setPosition()
    }
    
    private func setPosition() {
        getDispatcher().dispatch(SetGameState(fen: fenEdit.stringValue))
    }
}

