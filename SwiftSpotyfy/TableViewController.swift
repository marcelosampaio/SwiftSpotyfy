//
//  TableViewController.swift
//  SwiftSpotyfy
//
//  Created by Marcelo Sampaio on 11/28/16.
//  Copyright © 2016 Marcelo Sampaio. All rights reserved.
//

import UIKit
import Alamofire


struct post {
    let mainImage : UIImage!
    let name : String!
    
}



class TableViewController: UITableViewController {

    // MARK: Working Variables
    var searchURL = "https://api.spotify.com/v1/search?q=Shawn+Mendes&type=track"
    var posts = [post]()
    
    
    // Object Alias or Type Alias
    typealias JSONStandard = [String : AnyObject]
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Searching with alamofire help
        callAlamo(url: searchURL)
        
        
    }

    
    // MARK: Alamofire
    private func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
    }
    
    private func parseData (JSONData : Data){
        do{
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            
            print ("👉  readable JSON: \(readableJSON)")
            

            if let tracks = readableJSON["tracks"] as? JSONStandard{
                if let items = tracks["items"] as? [JSONStandard] {
                    
                    for i in 0..<items.count{
                        let item = items[i]
                        
                        // Track's name
                        let name = item["name"] as! String
                        
                        // Image of the album
                        if let album = item["album"] as? JSONStandard {
                            if let images = album["images"] as? [JSONStandard] {
                                let imageData = images[0]  // first occurrance of the images
                                let mainImageURL = URL(string: imageData["url"] as! String)
                                let mainImageData = try Data(contentsOf: mainImageURL!)
                                
                                // finally the image itself :)
                                let mainImage = UIImage(data: mainImageData)

                                posts.append(post.init(mainImage: mainImage!, name: name))
                                
                                // reload data in table view
                                self.tableView.reloadData()
                                
                            }
                        }
                        
                    }
                }
            }

        }
        catch{
            print(error)
        }
    }
    
    
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = posts[indexPath.row].name
        cell.imageView?.image = posts[indexPath.row].mainImage
        

        return cell
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
