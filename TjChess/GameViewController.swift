//
//  ViewController.swift
//  TjChess
//
//  Created by Tony on 26/02/2024.
//

import Cocoa

class GameViewController: NSViewController {
    private let dispatcher: EventDispatcher
    
    required init?(coder: NSCoder) {
        dispatcher = getDispatcher()
        super.init(coder: coder)
        dispatcher.register(processEvent)
    }
    
    func processEvent(_ event: Any) {
        if let event = event as? GlobalEvent {
            switch event {
            case .showError(let message):
                let alert = NSAlert()
                alert.messageText = message
                alert.alertStyle = .warning
                alert.runModal()
                
            case .gameOver(let result):
                let alert = NSAlert()
                alert.messageText = {
                    switch result {
                    case .blackWin:
                        return "Black wins"
                    case .whiteWin:
                        return "White wins"
                    default:
                        return "Game drawn"
                    }
                }()
                
                alert.alertStyle = .informational
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
        let dispatcher = getDispatcher()
        dispatcher.dispatch(GlobalEvent.setGameState(fen: fenEdit.stringValue))
        dispatcher.dispatch(GlobalEvent.setRunMode(runMode: .humanVsHuman))
        dispatcher.dispatch(GlobalEvent.startGame)
    }
}

