Extension { #name : #FamixPWBIndexedFileAnchor }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBIndexedFileAnchor >> dpFileName [
	^ self fileName copyReplaceAll: 'cleaned' with: 'dpcleaned'
]
