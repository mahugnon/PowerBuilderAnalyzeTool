Class {
	#name : #BrowserModeStrategy,
	#superclass : #Object,
	#category : #'PowerBuilderAnalyzeTool-BrowserModeStrategy'
}

{ #category : #'as yet unclassified' }
BrowserModeStrategy class >> actionFor: aBrowser [
	^ (self subclasses detect: [ :aStrategy | aStrategy mode: aBrowser ])
		new applyOn: aBrowser
]

{ #category : #'as yet unclassified' }
BrowserModeStrategy class >> mode: aBrowser [
	^ self subclassResponsibility
]

{ #category : #'target resize' }
BrowserModeStrategy >> applyOn: aBrowser [
	^ self subclassResponsibility
]
