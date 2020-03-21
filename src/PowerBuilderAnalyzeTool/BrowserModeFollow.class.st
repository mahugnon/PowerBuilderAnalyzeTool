Class {
	#name : #BrowserModeFollow,
	#superclass : #AbstractBrowserMode,
	#category : #'PowerBuilderAnalyzeTool-BrowserMode'
}

{ #category : #visiting }
BrowserModeFollow class >> mode: aBrowser [
	^ aBrowser isFollow
]

{ #category : #'target resize' }
BrowserModeFollow >> applyOn: aBrowser [
	^ aBrowser followAction
]
