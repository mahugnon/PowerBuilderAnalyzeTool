Class {
	#name : #PWBNonUsedVariableBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#instVars : [
		'model'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBNonUsedVariableBrowserTest >> setUp [
	super setUp.
	model := PWBNonUsedVariableBrowserModel new
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> testModelIsWellInitialized [
	self assert: model insVarLocaVarArgs isNotNil.
	self assert: model functions isNotNil.
	self assert: model instAndVars isNotNil.
	self assert: model variables isNotNil
]
