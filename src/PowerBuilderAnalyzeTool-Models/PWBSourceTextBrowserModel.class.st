Class {
	#name : #PWBSourceTextBrowserModel,
	#superclass : #Object,
	#instVars : [
		'selected'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
PWBSourceTextBrowserModel >> selected [
	^ selected
]

{ #category : #accessing }
PWBSourceTextBrowserModel >> selected: anObject [
	selected := anObject
]

{ #category : #accessing }
PWBSourceTextBrowserModel >> sourceText [
	^ selected sourceText
]
