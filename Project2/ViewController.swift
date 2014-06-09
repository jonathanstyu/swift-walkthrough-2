//
//  ViewController.swift
//  Project2
//
//  Created by Jonathan Yu on 6/8/14.
//  Copyright (c) 2014 Jonathan Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var appsTableView : UITableView
    var data: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchItunesFor("JQ software")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchItunesFor(searchTerm: String) {
        // iTunes API wants multiple terms separated by + symbols so replace spaces with +
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // escape anything unfriendly
        var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        println("Search ITUNES at URL \(url)")
        
        connection.start()
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append received chunk of data to our data object
        self.data.appendData(data)
    }


}

