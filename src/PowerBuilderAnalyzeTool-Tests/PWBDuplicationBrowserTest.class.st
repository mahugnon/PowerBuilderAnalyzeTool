Class {
	#name : #PWBDuplicationBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfCharactersInputIntialIs55 [
	| duplicationBrowser |
	duplicationBrowser := PWBDuplicationBrowser new.
	self
		assert: duplicationBrowser minNumberOfCharactersInput text
		equals: 55
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfLinesTextInputIntialIs10 [
	| duplicationBrowser |
	duplicationBrowser := PWBDuplicationBrowser new.
	self
		assert: duplicationBrowser minNumberOfLinesTextInput text
		equals: 10
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinimumParamNumberOfLineChange [
	| duplicationBrowser |
	duplicationBrowser := PWBDuplicationBrowser new.
	duplicationBrowser minNumberOfLinesTextInput text: 5.
	self assert: duplicationBrowser minNumberOfLines equals: 5
]
