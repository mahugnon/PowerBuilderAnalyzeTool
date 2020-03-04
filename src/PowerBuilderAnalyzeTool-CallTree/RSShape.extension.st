Extension { #name : #RSShape }

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
RSShape >> unMark [
	self model allTags do: [ :tag | self model removeTag: tag ]
]
