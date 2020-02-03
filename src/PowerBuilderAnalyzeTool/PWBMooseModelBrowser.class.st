Class {
	#name : #PWBMooseModelBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'modelPresenter',
		'searchField'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #specs }
PWBMooseModelBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #searchField
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #modelPresenter;
		yourself
]

{ #category : #examples }
PWBMooseModelBrowser class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBMooseModelBrowser >> accept: anObject [
	^ ({DPFragmentLocation.
	FamixPWBEvent} includes: anObject class) not
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializePresenters [
	model := PWBMooseModelBrowserModel new.
	self initializeTable.
	self initializeSearchField.
	modelPresenter
		whenSelectionChangedDo: [ :selected | 
			model selected: selected selectedItem.
			self globallySelect: selected selectedItem ].
	searchField
		whenTextIsAcceptedDo: [ :text | modelPresenter searchFor: text ]
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializeSearchField [
	searchField := self newTextInput
		placeholder: 'rechercher dans le model ...';
		yourself.
	searchField acceptOnCR: true
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializeTable [
	| title |
	modelPresenter := self newTreeTable.
	title := 'Source code components'.
	modelPresenter
		addColumn:
			(SpCompositeTableColumn new
				title: title;
				addColumn:
					((SpImageTableColumn evaluated: #systemIcon)
						width: 20;
						yourself);
				addColumn: (SpStringTableColumn evaluated: #name);
				yourself);
		addColumn:
			(SpStringTableColumn
				title: 'Number of Line of code'
				evaluated: [ :elt | elt numberOfLinesOfCode ]);
		addColumn:
			(SpStringTableColumn
				title: 'Number of invocation'
				evaluated: [ :elt | elt numberOfIncomingInvocations ]);
		roots: {model pbModel};
		children: [ :elt | elt content ];
		beResizable
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 600 @ 400
]

{ #category : #accessing }
PWBMooseModelBrowser >> modelPresenter [
	^ modelPresenter
]

{ #category : #'as yet unclassified' }
PWBMooseModelBrowser >> needUpdate: anEntity [
	^ model selected ~= anEntity
]

{ #category : #accessing }
PWBMooseModelBrowser >> selectEntity: anEntity [
	((self needUpdate: anEntity) and: [ self accept: anEntity ])
		ifFalse: [ ^ self ].
	modelPresenter selectItem: anEntity
	"self needRebuild: false.
	self buildWithSpec"
]

{ #category : #accessing }
PWBMooseModelBrowser >> selected [
	^ model selected
]

{ #category : #testing }
PWBMooseModelBrowser >> setModelPresenterSelection [
	modelPresenter selectItem: modelPresenter roots first
]

{ #category : #TOREMOVE }
PWBMooseModelBrowser >> title [
^'MooseModel Browser'
]
