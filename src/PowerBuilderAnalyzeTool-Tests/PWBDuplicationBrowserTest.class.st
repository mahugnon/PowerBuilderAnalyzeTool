Class {
	#name : #PWBDuplicationBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBDuplicationBrowserTest >> setUp [
	pwbCallTreeBrowser := PWBCallTreeBrowser new.
	pwbCallTreeBrowserModel := pwbCallTreeBrowser model.
	testModel := FamixPWBModel new.
	self initializeTestUserObject.
	self initializeTestFunctions.
	self initializeVariables.
	self initializeAccess
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfCharactersChange [
	| duplicationBrowser |
	duplicationBrowser := PWBDuplicationBrowser
		testLunchOn: testUserObject1.
	duplicationBrowser minNumberOfCharactersInput text: 5.
	self assert: duplicationBrowser minNumberOfCharacters equals: 5
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfCharactersInputIntialIs55 [
	| duplicationBrowser |
	duplicationBrowser := PWBDuplicationBrowser
		testLunchOn: testUserObject1.
	self
		assert: duplicationBrowser minNumberOfCharactersInput text asInteger
		equals: 55
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfLinesTextInputIntialIs10 [
	| duplicationBrowser |
	duplicationBrowser := PWBDuplicationBrowser
		testLunchOn: testUserObject1.
	self
		assert: duplicationBrowser minNumberOfLinesTextInput text asInteger
		equals: 10
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinimumParamNumberOfLineChange [
	| duplicationBrowser |
	duplicationBrowser := PWBDuplicationBrowser
		testLunchOn: testUserObject1.
	duplicationBrowser minNumberOfLinesTextInput text: 5.
	self assert: duplicationBrowser minNumberOfLines equals: 5
]
