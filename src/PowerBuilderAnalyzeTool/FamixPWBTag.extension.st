Extension { #name : #FamixPWBTag }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> isCIMObsolette [
	^ self new
		name: 'Obsolette';
		color: Color red
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> notSure [
	^ self new
		name: 'Not sure';
		color: Color yellow
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBTag class >> toRefactor [
	^ self new
		name: 'To be refactored';
		color: Color orange
]
