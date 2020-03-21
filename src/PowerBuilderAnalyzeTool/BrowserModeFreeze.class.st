Class {
	#name : #BrowserModeFreeze,
	#superclass : #BrowserModeStrategy,
	#category : #'PowerBuilderAnalyzeTool-BrowserModeStrategy'
}

{ #category : #'as yet unclassified' }
BrowserModeFreeze class >> mode: aBrowser [
	^ aBrowser isFreeze
]

{ #category : #'target resize' }
BrowserModeFreeze >> applyOn: aBrowser [
	^ aBrowser freezeAction
]
