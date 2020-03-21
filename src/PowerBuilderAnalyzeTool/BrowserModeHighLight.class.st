Class {
	#name : #BrowserModeHighLight,
	#superclass : #AbstractBrowserMode,
	#category : #'PowerBuilderAnalyzeTool-BrowserMode'
}

{ #category : #'as yet unclassified' }
BrowserModeHighLight class >> mode: aBrowser [
	^ aBrowser isHighlight
]

{ #category : #'target resize' }
BrowserModeHighLight >> applyOn: aBrowser [
	^ aBrowser highlightAction
]
