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
PWBNonUsedVariableBrowserTest >> testFunctionForInstanceVarShouldRetunEmptyCollection [
	self assert: (self model functionsFor: testInstVar1 name) isEmpty
]

{ #category : #tests }
PWBNonUsedVariableBrowserTest >> testFunctionsForArguments [
	self assert: (self model functionsFor: 'Arguments') isNotEmpty
]

{ #category : #tests }
PWBNonUsedVariableBrowserTest >> testFunctionsForLocalVars [
	self assert: (self model functionsFor: 'Local Variables') isNotEmpty
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> testModelIsWellInitialized [
	self assert: self model insVarLocaVarArgs isNotNil.
	self assert: self model functions isNotNil.
	self assert: self model instAndVars isNotNil.
	self assert: self model variables isNotNil
]

{ #category : #tests }
PWBNonUsedVariableBrowserTest >> testTrasmissionsToInstVarArgs [
	self
		assertCollection: (self model instOrVarFor: 'Attributs')
		hasSameElements:
			{testInstVar3 name.
			testInstVar4 name}.
	self
		assertCollection: (self model instOrVarFor: 'Variables')
		hasSameElements: {'Local Variables' . 'Arguments'}
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> testWhenSelectedEntityInstAndVarListShouldBeUpdated [
	self deny: browser instAndVarList model items isEmpty
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserTest >> testWhenSelectionChangedForTheFirstTimeInstAndVarsBecomeADictionnaryWith2Keys [
	self assert: self model instAndVars isDictionary.
	self
		assertCollection: self model instAndVars keys
		hasSameElements: {'Attributs' . 'Variables'}
]
