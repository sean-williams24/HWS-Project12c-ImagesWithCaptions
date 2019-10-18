//
//  PhotosTableVC.swift
//  Project 12c - Milestone - Images with Captions
//
//  Created by Sean Williams on 18/10/2019.
//  Copyright © 2019 Sean Williams. All rights reserved.
//

import UIKit

class PhotosTableVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraButton: UIBarButtonItem!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let jsonDecoder = JSONDecoder()
        
        if let photosData = UserDefaults.standard.object(forKey: "photos") as? Data {
            
            do {
                photos = try jsonDecoder.decode([Photo].self, from: photosData)
            } catch {
                print("Data could not be decdoded")
            }
        }


    }

    // MARK: - Table view data source & Delegates


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let photo = photos[indexPath.row]
        print(photo.imageName)
        
        let path = getDocumentsDirectory().appendingPathComponent(photo.imageName)
        print(path.path)
        cell.photoView.image = UIImage(contentsOfFile: path.path)
        cell.captionLabel.text = photo.caption
        
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "photo")
        vc.ph
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            photos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            save()
        }
    }
    
    
    //MARK: - Image Picker Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        //Write image to disk as jpeg
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let photo = Photo(imageName: imageName, caption: "Tap to write caption")
        photos.append(photo)
        save()
        
        tableView.reloadData()

        dismiss(animated: true)
        
        let ac = UIAlertController(title: "Add Caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            
            photo.caption = caption
            self?.save()
            self?.tableView.reloadData()
        }))
        present(ac, animated: true)
    }


    //MARK: - Private Methods
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

    //Encode photos aray to json data and save to user defaults
    func save() {
        let jsonEncoder = JSONEncoder()

        if let savedData =  try? jsonEncoder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "photos")
        }
    }
    
    
    //MARK: Action Methods
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
        } else {
            imagePickerController.sourceType = .photoLibrary
        }
        
        present(imagePickerController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
