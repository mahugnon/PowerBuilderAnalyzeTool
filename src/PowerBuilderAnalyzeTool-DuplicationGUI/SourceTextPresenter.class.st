Class {
	#name : #SourceTextPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'sourceText',
		'noteBook',
		'sourceCodePage'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-core'
}

{ #category : #specs }
SourceTextPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #noteBook;
		yourself
]

{ #category : #initialization }
SourceTextPresenter >> entityName: aString [
	sourceCodePage title: aString , ' source code'
]

{ #category : #initialization }
SourceTextPresenter >> initializePresenter [ 
]

{ #category : #initialization }
SourceTextPresenter >> initializeWidgets [
	sourceText := self newText.
	noteBook := self newNotebook.
	self sourceCodePage.
	noteBook addPage: sourceCodePage
]

{ #category : #initialization }
SourceTextPresenter >> sourceCodePage [
	sourceCodePage := SpNotebookPage
		title: 'Source code'
		icon: (self iconNamed: #nautilusIcon)
		provider: [ sourceText ]
]

{ #category : #accessing }
SourceTextPresenter >> text: aText [
  sourceText text: aText
]
