Class {
	#name : #PWBBrowserToolBar,
	#superclass : #PWBPresenter,
	#instVars : [
		'callTreeBrowser',
		'callTreeBrowserLabel',
		'duplicationBrowser',
		'duplicationBrowserLabel',
		'mooseModelBrowser',
		'mooseModelBrowserLabel',
		'sourceTextBrowser',
		'sourceTextBrowserLabel'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #specs }
PWBBrowserToolBar class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #duplicationBrowserLabel;
				add: #mooseModelBrowser;
				yourself);
		add:
			(SpBoxLayout newVertical
				add: #duplicationBrowserLabel;
				add: #duplicationBrowser;
				yourself);
		add:
			(SpBoxLayout newVertical
				add: #callTreeBrowserLabel;
				add: #callTreeBrowser;
				yourself);
		add:
			(SpBoxLayout newVertical
				add: #sourceTextBrowserLabel;
				add: #sourceTextBrowser;
				yourself);
		yourself
]

{ #category : #examples }
PWBBrowserToolBar class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
PWBBrowserToolBar >> initializeCallTreeBrowserLuncher [
	callTreeBrowser := self newButton
		icon: PWBBrowserIcons callTreeLogo;
		action: [ PWBCallTreeBrowser run ]";
		title: 'Open the call graph browser'".
	callTreeBrowserLabel := self newLabel label: 'Call Graph Browser'
]

{ #category : #initialization }
PWBBrowserToolBar >> initializeDuplicationBrowserLuncher [
	duplicationBrowser := self newButton
		icon: PWBBrowserIcons duplicationLogo;
		action: [ PWBDuplicationBrowser runMe ]";
		title: 'Open the duplication browser'".
	duplicationBrowserLabel := self newLabel label: 'Duplication Browser'
]

{ #category : #initialization }
PWBBrowserToolBar >> initializeMooseModelBrowserLauncher [
	mooseModelBrowser := self newButton
		icon: PWBBrowserIcons mooseModelLogo;
		action: [ ";
		title: 'Open the Source code FamixModel Browser'" PWBMooseModelBrowser runMe ].
	mooseModelBrowserLabel := self newLabel label: 'Model Browser'
]

{ #category : #initialization }
PWBBrowserToolBar >> initializePresenters [
	self initializeDuplicationBrowserLuncher.
	self initializeCallTreeBrowserLuncher.
	self initializeMooseModelBrowserLauncher.
	self initializeSourceTextBrowserLauncher
]

{ #category : #initialization }
PWBBrowserToolBar >> initializeSourceTextBrowserLauncher [
	sourceTextBrowser := self newButton
		icon: PWBBrowserIcons sourceTextLogo;
		action: [ PWBSourceTextBrowser runMe ]";
		title: 'Open the source code Browser'".
	sourceTextBrowserLabel := self newLabel label: 'Source code Browser'
]

{ #category : #initialization }
PWBBrowserToolBar >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenClosedDo: [ self application close ].
	aWindowPresenter
		title: self title;
		initialExtent: 600 @ 150;
		isResizeable: false
]

{ #category : #initialization }
PWBBrowserToolBar >> title [
^'PWBAnalyzeTool Luncher'
]
