//
//  CatsTableViewController.swift
//  Paws
//
//  Created by Артем on 18.04.15.
//  Copyright (c) 2015 Artem Novichkov. All rights reserved.
//

import UIKit

class CatsTableViewController: PFQueryTableViewController {
    let cellIdentifier:String = "CatsTableViewCell"
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        self.parseClassName = className
        self.tableView.rowHeight = 350
        self.tableView.allowsSelection = false
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.registerNib(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        
    }
    required init!(coder aDecoder: NSCoder!) {
        fatalError("NSCoding not supported")
    }
    override func queryForTable() -> PFQuery {
        var query:PFQuery = PFQuery(className: self.parseClassName!)
        
        if (objects?.count == 0) {
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        query.orderByAscending("name")
        return query
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        var cell:CatsTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CatsTableViewCell
        if (cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed(cellIdentifier, owner: self, options: nil)[0] as? CatsTableViewCell
        }
        cell?.parseObject = object
        if let pfObject = object {
            cell?.catNameLabel?.text = pfObject["name"] as? String
            var votes:Int? = pfObject["votes"] as? Int
            if votes == nil {
                votes = 0
            }
            cell?.catVotesLabel?.text = "\(votes!) votes"
            var credit:String? = pfObject["cc_by"] as? String
            if credit != nil {
                cell?.catCreditLabel?.text = "\(credit!) CC 2.0"
            }
            cell?.catImageView?.image = nil
            if var urlString:String? = pfObject["url"] as? String {
                var url:NSURL? = NSURL(string: urlString!)
                if var url:NSURL? = NSURL(string: urlString!) {
                    var error:NSError?
                    var request:NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 5.0)
                    NSOperationQueue.mainQueue().cancelAllOperations()
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse!, imageData:NSData!, error:NSError!) -> Void in
                        cell?.catImageView?.image = UIImage(data: imageData)
                    })
                }
            }
        }
        return cell
    }
}
