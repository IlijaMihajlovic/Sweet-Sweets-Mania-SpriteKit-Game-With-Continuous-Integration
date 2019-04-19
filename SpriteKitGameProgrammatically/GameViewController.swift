

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

let stopBackgroundMusicNotificationName = Notification.Name("stopBackgroundMusicNotificationName")
let startBackgroundMusicNotificationName = Notification.Name("startBackgroundMusicNotificationName")

let startGameplayNotificationName = Notification.Name("startGameplayNotificationName")

class GameViewController: UIViewController {
    
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backgroundMusic: AVAudioPlayer? = {
        guard let url = Bundle.main.url(forResource:  kBackgroundMusicName, withExtension: kBackgroundMusicExtension) else {
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            return player
        } catch {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skView)
        
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        let scene = MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.heigth))
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        
        addNotificationObservers()
        
        playStopBackgroundMusic()
    }
    
    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.stopBackgroundMusic(_:)), name: stopBackgroundMusicNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.startBackgroundMusic(_:)), name: startBackgroundMusicNotificationName, object: nil)
    }
    
    func playStopBackgroundMusic() {
        backgroundMusic?.play()
    }
    
    @objc func stopBackgroundMusic(_ info:Notification) {
        if ACTPlayerStats.shared.getSound() {
            backgroundMusic?.stop()
        }
    }
    
    @objc func startBackgroundMusic(_ info:Notification) {
        if ACTPlayerStats.shared.getSound() {
            backgroundMusic?.play()
        }
    }
    
}
