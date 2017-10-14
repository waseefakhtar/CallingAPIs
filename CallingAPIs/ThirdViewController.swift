//
//  ThirdViewController.swift
//  CallingAPIs
//
//  Created by Waseef Akhtar on 10/15/17.
//  Copyright © 2017 Waseef Akhtar. All rights reserved.
//

import UIKit

class ThirdViewController: UITableViewController, TWTRTweetViewDelegate {

    let tweetTableReuseIdentifier = "TweetCell"
    // Hold all the loaded Tweets
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    let tweetIDs = ["20", // @jack's first Tweet
        "510908133917487104"] // our favorite bike Tweet
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension 
        tableView.allowsSelection = false
        tableView.register(TWTRTweetTableViewCell.self, forCellReuseIdentifier: tweetTableReuseIdentifier)
        
        Twitter.sharedInstance().logIn(completion: { guestSession, error in
            if (guestSession != nil) {
                // make API calls that do not require user auth
            } else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        })
        
        let apiClient = TWTRAPIClient.init(userID: "waseefakhtar")
        apiClient.loadTweets(withIDs: tweetIDs, completion: { tweets,error  in
            if let ts = tweets {
                self.tweets = ts
            } else {
                print("Failed to load tweets: \(String(describing: error?.localizedDescription))")
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tweets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let tweet = tweets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: tweetTableReuseIdentifier, for: indexPath) as! TWTRTweetTableViewCell
        cell.tweetView.delegate = self

        return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]

        return TWTRTweetTableViewCell.height(for: tweet, style: TWTRTweetViewStyle.compact, width: self.view.bounds.width, showingActions: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
