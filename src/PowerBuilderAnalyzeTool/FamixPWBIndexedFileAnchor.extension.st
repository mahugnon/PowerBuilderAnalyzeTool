Extension { #name : #FamixPWBIndexedFileAnchor }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBIndexedFileAnchor >> dpFileName [
	^ self fileName copyReplaceAll: 'cleaned' with: 'dpcleaned'
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBIndexedFileAnchor >> dpFileReference [
	^ self rootFolder asFileReference resolve: self dpFileName
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBIndexedFileAnchor >> dpSourceText [
	| start |
	self sourcesAreReadable
		ifFalse: [ ^ '' ].
	start := startPos ifNil: [ 1 ].
	^ self dpFileReference
		binaryReadStreamDo: [ :in | 
			| stream |
			stream := ZnCharacterReadStream on: in encoding: self encoding.
			1 to: start - 1 do: [ :i | stream next ].
			stream next: (endPos ifNil: [ in size + 1 ]) - start + 1 ]
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBIndexedFileAnchor >> dpsourceText [
	self shouldBeImplemented.
]
