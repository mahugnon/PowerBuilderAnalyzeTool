Class {
	#name : #PWBSourceTextBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'sourceText',
		'noteBook',
		'sourceCodePage'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #specs }
PWBSourceTextBrowser class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #noteBook;
		yourself
]

{ #category : #initialization }
PWBSourceTextBrowser >> entityName: aString [
	sourceCodePage title: aString , ' source code'
]

{ #category : #initialization }
PWBSourceTextBrowser >> initializePresenter [ 
]

{ #category : #initialization }
PWBSourceTextBrowser >> initializeWidgets [
	sourceText := self newText.
	noteBook := self newNotebook.
	self sourceCodePage.
	noteBook addPage: sourceCodePage
]

{ #category : #initialization }
PWBSourceTextBrowser >> sourceCodePage [
	sourceCodePage := SpNotebookPage
		title: 'Source code'
		icon: (self iconNamed: #nautilusIcon)
		provider: [ sourceText ]
]

{ #category : #accessing }
PWBSourceTextBrowser >> text: aText [
  sourceText text: aText
]

{ #category : #updating }
PWBSourceTextBrowser >> updateCode [
	sourceCodePanel text: model fragmentText.
	sourceCodePanel entityName: model selectedFragmentLocationName
]
