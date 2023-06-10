//
//  Image+CoreDataProperties.swift
//  Image Generator
//
//  Created by Дмитрий Скок on 08.06.2023.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var img: Data?

}
