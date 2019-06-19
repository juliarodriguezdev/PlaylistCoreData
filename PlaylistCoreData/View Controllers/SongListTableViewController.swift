//
//  SongListTableViewController.swift
//  PlaylistCoreData
//
//  Created by julia rodriguez on 6/19/19.
//  Copyright © 2019 julia rodriguez. All rights reserved.
//

import UIKit

class SongListTableViewController: UITableViewController {
    
    // Create a landing pad (to recieve data from)
    var playListLandingPad: Playlist?
    
    @IBOutlet weak var songNameTextField: UITextField!
    
    @IBOutlet weak var artistNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = playListLandingPad?.name

    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let title = songNameTextField.text, title != "",
            let artist = artistNameTextField.text, artist != "" else { return }
        guard let playlist = playListLandingPad else { return }
        SongController.sharedInstance.createNewSongWith(title: title, artist: artist, playlist: playlist)
        
        // For User: clear data inputted after Save Button Pressed
        songNameTextField.text = ""
        artistNameTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return playListLandingPad?.songs?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)

        // Configure the cell...
        guard let song = playListLandingPad?.songs?[indexPath.row] as? Song else {
            return UITableViewCell() }
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let song = playListLandingPad?.songs?[indexPath.row] as? Song else { return }
            
            SongController.sharedInstance.delete(song: song)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
    
    }
}
}
