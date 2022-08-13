//
//  PlayerViewController.swift
//  iOSMusicApp
//
//  Created by Kaan Yeyrek on 8/11/22.
//

import UIKit
import AVFoundation




class PlayerViewController: UIViewController {

    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    
    var player: AVAudioPlayer?
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
        
        
        
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
        
        
    }()
    
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
        
        
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
        
        
    }()
    
    let playPauseButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
        
    }
    
        
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
            
        }
    }
       func configure() {
           
           let song = songs[position]
           let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
            
           do {
             try AVAudioSession.sharedInstance().setMode(.default)
             try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
               guard let urlString = urlString else { return }
               player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
               guard let player = player else { return }
               player.volume = 0.5
               player.play()
               
               
           } catch {
               print("error occurred")
           }
       
           
           
           
          
           
           
           albumImageView.frame = CGRect(x: 10,
                                       y: 10,
                                       width: holder.frame.size.width-20,
                                       height: holder.frame.size.width-20)
           albumImageView.image = UIImage(named: song.imageName)
           holder.addSubview(albumImageView)
           
              
           songNameLabel.frame = CGRect(x: 10,
                                        y: albumImageView.frame.size.height + 10,
                                         width: holder.frame.size.width-20,
                                         height: 150)
           albumNameLabel.frame = CGRect(x: 10,
                                            y: albumImageView.frame.size.height + 10 + 70,
                                            width: holder.frame.size.width-20,
                                            height: 150)
              
           artistNameLabel.frame = CGRect(x: 10,
                                          y: albumImageView.frame.size.height + 10 + 140,
                                          width: holder.frame.size.width-20,
                                         height: 150)
          
           artistNameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
           songNameLabel.font = UIFont(name: "Helvetica-Bold", size: 25)
           albumNameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
           
           
              songNameLabel.text = song.name
              albumNameLabel.text = song.albumName
              artistNameLabel.text = song.artistName
           
          
           
           holder.addSubview(artistNameLabel)
           holder.addSubview(albumNameLabel)
           holder.addSubview(songNameLabel)
         
          
             
        
         let nextButton = UIButton()
         let backButton = UIButton()
           
           
           let yPosition = artistNameLabel.frame.origin.y + 70 + 20
           let size: CGFloat = 50
           
           playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2, y: yPosition + 35, width: size, height: size)
           nextButton.frame = CGRect(x: holder.frame.size.width - size - 20, y: yPosition + 35, width: size, height: size)
           backButton.frame = CGRect(x: 20, y: yPosition + 35, width: size, height: size)
           
           
           
           playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
           nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
           backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
           
           
           playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
           nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
           backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
           
           playPauseButton.tintColor = .black
           nextButton.tintColor = .black
           backButton.tintColor = .black
           
           holder.addSubview(playPauseButton)
           holder.addSubview(nextButton)
           holder.addSubview(backButton)

            
           
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height-60, width: holder.frame.size.width-40, height: 50))
        
           slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        slider.value = 0.5
        holder.addSubview(slider)
       }
    
           @objc func didTapBackButton() {
               if position > 0 {
                   position = position - 1
                   player?.stop()
                   for subView in holder.subviews {
                       subView.removeFromSuperview()
                   }
                   configure()
               }
           }
           @objc func didTapNextButton() {
               if position < (songs.count - 1) {
                   position = position + 1
                   player?.stop()
                   for subView in holder.subviews {
                       subView.removeFromSuperview()
                   }
                   configure()
               }
           }
           @objc func didTapPlayPauseButton() {
               
               if player?.isPlaying == true {
                   player?.pause()
                   playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
                   UIView.animate(withDuration: 0.2, animations: {
                       self.albumImageView.frame = CGRect(x: 30, y: 30, width: self.holder.frame.size.width-60, height: self.holder.frame.size.width-60)
                   })
               }
               else {
                   player?.play()
                   playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
                   UIView.animate(withDuration: 0.2, animations: {
                       self.albumImageView.frame = CGRect(x: 10, y: 10, width: self.holder.frame.size.width-20, height: self.holder.frame.size.width-20)
                   })
               }
               
               
           }
           
     
        
    
       @objc func didSlideSlider(_ slider: UISlider) {
            let value = slider.value
            player?.volume = value
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }

}
