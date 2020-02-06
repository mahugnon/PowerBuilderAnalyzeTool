Class {
	#name : #PWBDuplicationBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBDuplicationBrowserTest >> setUp [
	super setUp.
	browser := PWBDuplicationBrowser new
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testCurrentStateChangeWhenRadionButtonIsActivated [
	browser toFrozen.
	self assert: browser isFreeze
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testCurrentStateIsFollowWhenLunch [
	self assert: browser isFollow
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfCharactersChange [
	browser minNumberOfCharactersInput text: 5.
	self assert: browser minNumberOfCharacters equals: 5
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfCharactersInputIntialIs55 [
	self
		assert: browser minNumberOfCharactersInput text asInteger
		equals: 55
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfLinesTextInputIntialIs50 [
	self
		assert: browser minNumberOfLinesTextInput text asInteger
		equals: 50
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinimumParamNumberOfLineChange [
	browser minNumberOfLinesTextInput text: 5.
	self assert: browser minNumberOfLines equals: 5
]
