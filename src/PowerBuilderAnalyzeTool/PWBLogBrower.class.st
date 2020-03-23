Class {
	#name : #PWBLogBrower,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'logsPresenter'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
PWBLogBrower class >> defaultSpec [
	^  super defaultSpec
		add: #logsPresenter;
		yourself
]

{ #category : #examples }
PWBLogBrower class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBLogBrower >> accept: anObject [
	^ true
]

{ #category : #initialization }
PWBLogBrower >> connectPresenters [ 
]

{ #category : #initialization }
PWBLogBrower >> initializePresenters [
	logsPresenter := self newList.
	logsPresenter
		items: self logger logs;
	"	display: [ :elt | 
			elt printString.
			self halt ];"
		sortingBlock: [ :a :b | a time > b time ];
		headerTitle: '             Activity Logs       '
]

{ #category : #initialization }
PWBLogBrower >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ self application windowClosed: aWindowPresenter ].
	aWindowPresenter
		title: self title;
		initialExtent: 400 @ 300
]

{ #category : #accessing }
PWBLogBrower >> logger [
	^ self application logger
]

{ #category : #accessing }
PWBLogBrower >> selectEntity: anEntity [
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #TOREMOVE }
PWBLogBrower >> title [
^'Activity Logger'
]
