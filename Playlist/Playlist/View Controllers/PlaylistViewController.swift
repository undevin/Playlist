//
//  PlaylistViewController.swift
//  Playlist
//
//  Created by Devin Flora on 1/12/21.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var playlistTitleTextField: UITextField!
    @IBOutlet weak var playlistTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        PlaylistController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createPlaylistButtonTapped(_ sender: Any) {
        guard let title = playlistTitleTextField.text, !title.isEmpty else { return }
        PlaylistController.shared.createPlaylistWith(title: title)
        playlistTableView.reloadData()
        playlistTitleTextField.text = ""
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistTableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        
        cell.textLabel?.text = playlist.title
        cell.detailTextLabel?.text = "\(playlist.songs.count) songs"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaytest(playlistToDelete: playlistToDelete)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSongList" {
            guard let indexPath = playlistTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? SongListTableViewController else { return }
            let playlistToSend = PlaylistController.shared.playlists[indexPath.row]
            destination.playlist = playlistToSend
        }
    }
}
