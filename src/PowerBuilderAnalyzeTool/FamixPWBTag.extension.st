Extension { #name : #FamixPWBTag }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> isCIMObsolette [
	^self tagNamed: 'Obsolette'
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> notSure [
	^ self tagNamed: 'Not sure'
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> toRefactor [
	^ self tagNamed: 'To be refactored'
]
