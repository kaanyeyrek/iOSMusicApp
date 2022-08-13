 //
//  ViewController.swift
//  iOSMusicApp
//
//  Created by Kaan Yeyrek on 8/11/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
    }

    
    func configureSongs() {
        songs.append(Song(name: "Viva la Vida", albumName: "123 Something", artistName: "Coldplay", imageName: "cover1", trackName: "song1"))
        songs.append(Song(name: "Nothing else Matters", albumName: "Metallica album", artistName: "James", imageName: "cover2", trackName: "song2"))
        songs.append(Song(name: "Havana", albumName: "Havana album", artistName: "Camilla Cabello", imageName: "cover3", trackName: "song3"))
        songs.append(Song(name: "Viva la Vida", albumName: "123 Something", artistName: "Coldplay", imageName: "cover1", trackName: "song1"))
        songs.append(Song(name: "Nothing else Matters", albumName: "Metallica album", artistName: "James", imageName: "cover2", trackName: "song2"))
        songs.append(Song(name: "Havana", albumName: "Havana album", artistName: "Camilla Cabello", imageName: "cover3", trackName: "song3"))
        songs.append(Song(name: "Viva la Vida", albumName: "123 Something", artistName: "Coldplay", imageName: "cover1", trackName: "song1"))
        songs.append(Song(name: "Nothing else Matters", albumName: "Metallica album", artistName: "James", imageName: "cover2", trackName: "song2"))
        songs.append(Song(name: "Havana", albumName: "Havana album", artistName: "Camilla Cabello", imageName: "cover3", trackName: "song3"))
        songs.append(Song(name: "Viva la Vida", albumName: "123 Something", artistName: "Coldplay", imageName: "cover1", trackName: "song1"))
        songs.append(Song(name: "Nothing else Matters", albumName: "Metallica album", artistName: "James", imageName: "cover2", trackName: "song2"))
        songs.append(Song(name: "Havana", albumName: "Havana album", artistName: "Camilla Cabello", imageName: "cover3", trackName: "song3"))
       
        
    }
    

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.imageView?.image = UIImage(named: song.imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else { return }
        vc.songs = songs
        vc.position = position
        
                present(vc, animated: true)
    }
}


struct Song {
    
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
    
}
