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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SongController.shared.loadFromPersistenceStore()
    }
    
    // MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
                                                    //Is not empty
        guard let songTitle = songTitleLabel.text, !songTitle.isEmpty,
              let artistName = artistNameLabel.text, !artistName.isEmpty else { return }
        
        SongController.shared.createSong(title: songTitle, artist: artistName)
        tableView.reloadData()
        songTitleLabel.text = ""
        artistNameLabel.text = ""
        // Pulls cursor from text field and hides keyboard from screen
        songTitleLabel.resignFirstResponder()
        artistNameLabel.resignFirstResponder()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongController.shared.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = SongController.shared.songs[indexPath.row]
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let songToDelete = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(songToDelete: songToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}//End of Class
