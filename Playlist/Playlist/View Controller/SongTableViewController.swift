//
//  SongTableViewController.swift
//  Playlist
//
//  Created by Cameron Stuart on 12/15/20.
//

import UIKit

class SongTableViewController: UITableViewController {

    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    var playlist: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text,
              !songTitle.isEmpty,
              let artistName = artistNameTextField.text,
              !artistName.isEmpty,
              let playlist = playlist else { return }
        SongController.createSong(title: songTitle, artist: artistName, playlist: playlist)
        tableView.reloadData()
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        songTitleTextField.becomeFirstResponder()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return playlist?.songs.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)

        guard let playlist = playlist else { return cell }
        
        let song = playlist.songs[indexPath.row]

        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            let songToDelte = playlist.songs[indexPath.row]
            SongController.deleteSong(song: songToDelte, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
