Class {
	#name : #FilterConsideredMethodTypeOption,
	#superclass : #AbstractOptions,
	#category : #'PowerBuilderAnalyzeTool-Utils-CallTreeOptions'
}

{ #category : #'as yet unclassified' }
FilterConsideredMethodTypeOption class >> optionName [
	^ 'Filter by methods type'
]

{ #category : #'target resize' }
FilterConsideredMethodTypeOption >> applyOn: aBrowser [
	aBrowser filterConsideredMethodTypeAction
]
