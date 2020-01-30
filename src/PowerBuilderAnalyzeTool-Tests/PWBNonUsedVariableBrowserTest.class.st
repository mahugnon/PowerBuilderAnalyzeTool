Class {
	#name : #PWBNonUsedVariableBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#instVars : [
		'browser'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> model [
	^ browser model
]

{ #category : #running }
PWBNonUsedVariableBrowserTest >> setUp [
	super setUp.
	browser := PWBNonUsedVariableBrowser new
		selectEntity: testUserObject1
]

{ #category : #tests }
PWBNonUsedVariableBrowserTest >> testTrasmissionsToInstVarArgs [
	self
		assertCollection: (self model instOrFunctionFor: 'Attributs')
		hasSameElements:
			{testInstVar3.
			testInstVar4}.
	self
		assertCollection: (self model instOrFunctionFor: 'Variables')
		hasSameElements:
			{testFunction2.
			testFunction1}
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> testWhenSelectedEntityInstAndVarListShouldBeUpdated [
	self deny: browser instAndVarList model items isEmpty
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> testWhenSelectionChangedForTheFirstTimeInstAndVarsBecomeADictionnaryWith2Keys [
	self
		assertCollection: self model instAndVars
		hasSameElements: {'Attributs' . 'Variables'}
]
