

import UIKit
import SpriteKit
import AVFoundation

let stopBackgroundMusicNotificationName = Notification.Name("stopBackgroundMusicNotificationName")
let startBackgroundMusicNotificationName = Notification.Name("startBackgroundMusicNotificationName")
let startGameplayNotificationName = Notification.Name("startGameplayNotificationName")
let setMusicVolumeNotificationName = Notification.Name("setMusicVolumeNotificationName")

class GameViewController: UIViewController {
    
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backgroundMusic: AVAudioPlayer? = {
        
        //Getting the path to the audio file
        guard let url = Bundle.main.url(forResource: kBackgroundMusicName, withExtension: kBackgroundMusicExtension) else {
            print("Unable to found audio file")
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            //repeat the backgorund music forever
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
        
       // addNotificationObservers()
        
        playStopBackgroundMusic()
        
        //Sets the configured volume when the apps starts
        let info = ["volume": ACTPlayerStats.shared.getMusicVolume()]
        NotificationCenter.default.post(name: setMusicVolumeNotificationName, object: nil, userInfo: info)
    }
    
    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.stopBackgroundMusic(_:)), name: stopBackgroundMusicNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.startBackgroundMusic(_:)), name: startBackgroundMusicNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setMusicVolume(_:)), name: setMusicVolumeNotificationName, object: nil)
    }
    
    func playStopBackgroundMusic() {
        if ACTPlayerStats.shared.getSound() {
            backgroundMusic?.play()
        
        } else {
            backgroundMusic?.stop()
        }
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
        @objc func setMusicVolume(_ info:Notification) {
            guard let userInfo = info.userInfo else {return}
            let volume = userInfo["volume"] as! Float
            setBackgroundMusicVolume(to: volume)
        }
        
        func setBackgroundMusicVolume(to volume: Float) {
            backgroundMusic?.volume = volume
        }
    }
    

