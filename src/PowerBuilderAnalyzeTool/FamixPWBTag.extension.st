Extension { #name : #FamixPWBTag }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> isCIMObsolette [
	^self pwbTags at: 'Obsolette'
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> notSure [
	^ tags at: 'Not sure'
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> toRefactor [
	^ tags at: 'To be refactored'
]
