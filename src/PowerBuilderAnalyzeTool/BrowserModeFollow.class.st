Class {
	#name : #BrowserModeFollow,
	#superclass : #BrowserModeStrategy,
	#category : #'PowerBuilderAnalyzeTool-BrowserModeStrategy'
}

{ #category : #visiting }
BrowserModeFollow class >> mode: aBrowser [
	^ aBrowser isFollow
]

{ #category : #'target resize' }
BrowserModeFollow >> applyOn: aBrowser [
	^ aBrowser followAction
]
