Extension { #name : #RSShape }

{ #category : #'*PowerBuilderAnalyzeTool' }
RSShape >> mark: elt as: aString [
	elt model tag: (elt model tagNamed: aString).
	^ elt color: (ColorObject colorFor: elt model)
]

{ #category : #'*PowerBuilderAnalyzeTool' }
RSShape >> markAs: aString [
	self model addTag: (self model tagNamed: aString).
	^ self color: (ColorObject colorFor: self model)
]
