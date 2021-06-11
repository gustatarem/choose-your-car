//
//  Sounds.swift
//  BookCore
//
//  Created by Gustavo Tatarem on 19/04/21.
//

import Foundation
import AVFoundation

class GSAudio: NSObject, AVAudioPlayerDelegate {

    static let sharedInstance = GSAudio()

    private override init() {}

    var players = [NSURL:AVAudioPlayer]()
    var duplicatePlayers = [AVAudioPlayer]()

    func playSound (soundFileName: String, loops: Bool = false){

        let soundFileNameURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: "wav")!)

        if let player = players[soundFileNameURL] { //player for sound has been found

            if loops {
                player.numberOfLoops = -1
            }
            
            if player.isPlaying == false { //player is not in use, so use that one
                player.prepareToPlay()
                player.play()
            } else { // player is in use, create a new, duplicate, player and use that instead

                let duplicatePlayer = try! AVAudioPlayer(contentsOf: soundFileNameURL as URL)
                //use 'try!' because we know the URL worked before.

                duplicatePlayer.delegate = self
                //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing

                duplicatePlayers.append(duplicatePlayer)
                //add duplicate to array so it doesn't get removed from memory before finishing

                duplicatePlayer.prepareToPlay()
                duplicatePlayer.play()

            }
        } else { //player has not been found, create a new player with the URL if possible
            do{
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL as URL)
                players[soundFileNameURL] = player
                if loops {
                    player.numberOfLoops = -1
                }
                player.prepareToPlay()
                player.play()
            } catch {
                print("Could not play sound file!")
            }
        }
    }

    func stopAll() {
      players.forEach { $0.1.stop() }
      duplicatePlayers.forEach { $0.stop() }
      players.removeAll()
      duplicatePlayers.removeAll()
    }
}
