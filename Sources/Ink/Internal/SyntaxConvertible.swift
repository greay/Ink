//
//  SyntaxConvertible.swift
//  
//
//  Created by greay on 12/19/19.
//

import Foundation

internal protocol SyntaxConvertible {
	func attributes(usingURLs urls: NamedURLCollection, modifiers: ModifierCollection) -> (String, [NSAttributedString.Key : Any]?)
}

extension SyntaxConvertible where Self: Modifiable {
	func highlighted(usingURLs urls: NamedURLCollection, rawString: Substring, applyingModifiers modifiers: ModifierCollection) -> NSAttributedString {
		var (str, attrs) = self.attributes(usingURLs: urls, modifiers: modifiers)

		modifiers.applyModifiers(for: modifierTarget) { modifier in
			str = modifier.closure((str, rawString))
		}

		return NSAttributedString(string: str, attributes: attrs)
	}
}
