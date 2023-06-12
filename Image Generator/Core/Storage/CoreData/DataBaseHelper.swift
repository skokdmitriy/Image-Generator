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

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()

    func saveImage(image: UIImage) {
        let image = image.pngData()
        let imageInstance = Image(context: persistentContainer.viewContext)
        imageInstance.img = image
        var fetchingImage = [Image]()

        do {
            fetchingImage = try persistentContainer.viewContext.fetch(fetchRequest)
            if fetchingImage.count == 6 {
                let image = fetchingImage.remove(at: 0)
                persistentContainer.viewContext.delete(image)
                try persistentContainer.viewContext.save()
            }
            try persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteImage(indexPath: IndexPath) {
        var fetchingImage = [Image]()

        do {
            fetchingImage = try persistentContainer.viewContext.fetch(fetchRequest)
            let image = fetchingImage.remove(at: indexPath.row)
            persistentContainer.viewContext.delete(image)
            try persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteAllImage() {
        if let objects = try? persistentContainer.viewContext.fetch(fetchRequest) {
            for object in objects {
                persistentContainer.viewContext.delete(object)
            }
        }

        do {
            try persistentContainer.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchImage() -> [UIImage] {
        var fetchingImage: [UIImage] = []

        do {
            let dataImage = try persistentContainer.viewContext.fetch(fetchRequest)
            fetchingImage = dataImage.compactMap { dataImage in
                guard let data = dataImage.img else {
                    return nil
                }
                return UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
        return fetchingImage
    }
}
