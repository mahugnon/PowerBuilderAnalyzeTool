Extension { #name : #MPImportMSECommand }

{ #category : #'*PowerBuilderAnalyzeTool' }
MPImportMSECommand >> execute [
	[ | model |
	model := FamixPWBModel new.
	model importFromMSE.
	model notEmpty
		ifTrue: [ model install.
			self addModel: model ] ] fork
]
