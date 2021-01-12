//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by Devin Flora on 1/11/21.
//

import UIKit

class SongListTableViewController: UITableViewController {

    // MARK: - Outlets
    @IBOutlet weak var songTitleLabel: UITextField!
    @IBOutlet weak var artistNameLabel: UITextField!
    
    // MARK: - Properties
    var playlist: Playlist?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleLabel.text, !songTitle.isEmpty,
              let artistName = artistNameLabel.text, !artistName.isEmpty,
              let playlist = playlist else { return }
        
        SongController.createSong(title: songTitle, artist: artistName, playlist: playlist)
        tableView.reloadData()
        songTitleLabel.text = ""
        artistNameLabel.text = ""
        // Pulls cursor from text field and hides keyboard from screen
        songTitleLabel.resignFirstResponder()
        artistNameLabel.resignFirstResponder()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.songs.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        guard let song = playlist?.songs[indexPath.row] else { return cell }
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            let songToDelete = playlist.songs[indexPath.row]
                SongController.deleteSong(songToDelete: songToDelete, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}//End of Class
