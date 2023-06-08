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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchedResultsController = NSFetchedResultsController<Image>()

    var dataImage = [Image]()

    func saveImage(data: Data) {
        let imageInstance = Image(context: context)
        imageInstance.img = data

        do {
            try context.save()
            print("Image saved")
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteImage(indexPath: IndexPath) {
        let image = fetchedResultsController.object(at: indexPath)
        context.delete(image)

        do {
            try context.save()
            print("Image remove first")
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
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()

        do {
            dataImage = try context.fetch(fetchRequest)
        } catch {
            print("Error while fetching the image")
        }
        return dataImage
    }
}
