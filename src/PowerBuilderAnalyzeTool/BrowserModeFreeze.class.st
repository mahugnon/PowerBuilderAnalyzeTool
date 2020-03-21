Class {
	#name : #BrowserModeFreeze,
	#superclass : #AbstractBrowserMode,
	#category : #'PowerBuilderAnalyzeTool-BrowserMode'
}

{ #category : #'as yet unclassified' }
BrowserModeFreeze class >> mode: aBrowser [
	^ aBrowser isFreeze
]

{ #category : #'target resize' }
BrowserModeFreeze >> applyOn: aBrowser [
	^ aBrowser freezeAction
]
