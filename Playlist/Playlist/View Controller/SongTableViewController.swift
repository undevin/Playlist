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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SongController.shared.loadFromPersistenceStore()
    }

    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text,
              !songTitle.isEmpty,
              let artistName = artistNameTextField.text,
              !artistName.isEmpty else { return }
        SongController.shared.createSong(title: songTitle, artist: artistName)
        tableView.reloadData()
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        songTitleTextField.becomeFirstResponder()
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
            let songToDelte = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(song: songToDelte)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
