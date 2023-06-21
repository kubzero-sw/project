//
//  PlayerViewController.swift
//  musicapp
//
//  Created by Rashid Karina on 25.04.2023.
//
import AVFoundation
import UIKit

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
    private let songNamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let aristNamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let albumNamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
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
        do{
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
        
            guard let player = player else {
                return
            }
            player.play()
        }
        catch {
            print("error occurred")
        }
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        songNamelabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 10,
                                      width: holder.frame.size.width-20,
                                      height:70)
        albumNamelabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 70,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        aristNamelabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 70 + 140,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        songNamelabel.text = song.name
        albumNamelabel.text = song.albumName
        aristNamelabel.text = song.artistName
        holder.addSubview(songNamelabel)
        holder.addSubview(albumNamelabel)
        holder.addSubview(aristNamelabel)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
        
    }
}
