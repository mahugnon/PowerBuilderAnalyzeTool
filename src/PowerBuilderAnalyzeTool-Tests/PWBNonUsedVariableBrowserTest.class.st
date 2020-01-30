Class {
	#name : #PWBNonUsedVariableBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#instVars : [
		'model',
		'browser'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBNonUsedVariableBrowserTest >> setUp [
	super setUp.
	model := PWBNonUsedVariableBrowserModel new.
	browser := PWBNonUsedVariableBrowser new
		selectEntity: testUserObject1
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> testModelIsWellInitialized [
	self assert: model insVarLocaVarArgs isNotNil.
	self assert: model functions isNotNil.
	self assert: model instAndVars isNotNil.
	self assert: model variables isNotNil
]

{ #category : #tests }
PWBNonUsedVariableBrowserTest >> testTrasmissionsToInstVarArgs [
	self
		assertCollection: (browser model instOrVarFor: 'Attributs')
		hasSameElements:
			{testInstVar3.
			testInstVar4}.
	self
		assertCollection: (browser model instOrVarFor: 'Variables')
		hasSameElements: {'Local Variables' . 'Arguments'}
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> testWhenSelectionChangedForTheFirstTimeInstAndVarsBecomeADictionnaryWith2Keys [
	self assert: browser model instAndVars isDictionary.
	self
		assertCollection: browser model instAndVars keys
		hasSameElements: {'Attributs' . 'Variables'}
]
