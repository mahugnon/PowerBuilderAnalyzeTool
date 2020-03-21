Class {
	#name : #BrowserModeHighLight,
	#superclass : #BrowserModeStrategy,
	#category : #'PowerBuilderAnalyzeTool-BrowserModeStrategy'
}

{ #category : #'as yet unclassified' }
BrowserModeHighLight class >> mode: aBrowser [
	^ aBrowser isHighlight
]

{ #category : #'target resize' }
BrowserModeHighLight >> applyOn: aBrowser [
	^ aBrowser highlightAction
]
