//
//  PlaylistListTableViewController.swift
//  PlaylistCoreData
//
//  Created by julia rodriguez on 6/19/19.
//  Copyright © 2019 julia rodriguez. All rights reserved.
//

import UIKit

class PlaylistListTableViewController: UITableViewController {

    @IBOutlet weak var playListNameTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = playListNameTextField.text, name != "" else { return }
        PlaylistController.sharedInstance.createPlaylistWith(name: name)
        
        playListNameTextField.text = ""
        // to refresh the screen
        tableView.reloadData()
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PlaylistController.sharedInstance.playlists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playListCell", for: indexPath)

        let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
       // Optional binding optional = optional
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "\((playlist.songs?.count) ?? 0) songs"

        return cell
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let playlist = PlaylistController.sharedInstance.playlists[indexPath.row]
            PlaylistController.sharedInstance.delete(playlist: playlist)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // Locate where on the table view user has selected
        guard let index = tableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? SongListTableViewController else { return }
        let playlistToSend = PlaylistController.sharedInstance.playlists[index.row]
        destinationVC.playListLandingPad = playlistToSend
    }


}
