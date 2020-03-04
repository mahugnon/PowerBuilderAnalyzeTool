Extension { #name : #RSShape }

{ #category : #'*PowerBuilderAnalyzeTool' }
RSShape >> markAs: aString [
	self model addTag: (self model tagNamed: aString).
	^ self color: (ColorObject colorFor: self model)
]
