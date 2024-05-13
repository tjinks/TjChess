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
                
            case .showPromotionDialog:
                showPromotionView()
                
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
        //fenEdit.stringValue = "7k/8/8/4K3/8/8/8/rn6 w"
        //fenEdit.stringValue = "k1b5/8/8/8/8/8/7P/K7 w"
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
        setPosition(runMode: .humanVsHuman)
    }
    
    @IBAction func humanVsComputerClicked(_ sender: Any) {
        setPosition(runMode: .humanVsComputer)
    }
    
    private func setPosition(runMode: RunMode) {
        let dispatcher = getDispatcher()
        dispatcher.dispatch(GlobalEvent.setGameState(fen: fenEdit.stringValue))
        dispatcher.dispatch(GlobalEvent.setRunMode(runMode: runMode))
        dispatcher.dispatch(GlobalEvent.startGame)
    }
    
    private func showPromotionView() {
        let secondaryWindowController: NSWindowController? = storyboard?.instantiateController<NSWindowController>(identifier: "promotionWindow") {
            coder in return nil
        }
        
        let window = secondaryWindowController!.window!
        NSApp.runModal(for: window)
    }
}

