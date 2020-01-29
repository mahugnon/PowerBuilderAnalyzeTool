Extension { #name : #PWBDuplicationBrowser }

{ #category : #'*PowerBuilderAnalyzeTool-Tests' }
PWBDuplicationBrowser class >> testLunchOn: anObject [
	^ self basicNew
		initializeModel;
		mooseModel: anObject;
		initialize;
		selectFirstItem
]
