//
//  DataBaseHelper.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 08.06.2023.
//

import UIKit
import CoreData

final class DataBaseHelper {
    static let shared = DataBaseHelper()

    private init() {}

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchedResultsController = NSFetchedResultsController<Image>()

    func saveImage(data: Data) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
        var fetchingImage = [Image]()
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()

        do {
            fetchingImage = try context.fetch(fetchRequest)
            if fetchingImage.count == 6 {
                let image = fetchingImage.remove(at: 0)
                context.delete(image)
                try context.save()
            }
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteImage(indexPath: IndexPath) {
        var fetchingImage = [Image]()
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()

        do {
            fetchingImage = try context.fetch(fetchRequest)
            let image = fetchingImage.remove(at: indexPath.row)
            context.delete(image)
            try context.save()
            print("Image remove indexPath")
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteAllImage() {
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }

        do {
            try context.save()
            print("Image remove")
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchImage() -> [Image] {
        var fetchingImage = [Image]()
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
        
        do {
            fetchingImage = try context.fetch(fetchRequest)
        } catch {
            print("Error while fetching the image")
        }
        return fetchingImage
    }
}
