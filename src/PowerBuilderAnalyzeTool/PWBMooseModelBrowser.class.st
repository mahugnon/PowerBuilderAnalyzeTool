Class {
	#name : #PWBMooseModelBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'modelPresenter',
		'searchField'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
PWBMooseModelBrowser class >> defaultSpec [
	^ super defaultSpec
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

{ #category : #accessing }
PWBMooseModelBrowser >> follow [
	^ follow
]

{ #category : #accessing }
PWBMooseModelBrowser >> followAction [
	(self needUpdate: toSelect)
		ifFalse: [ ^ self ].
	modelPresenter roots: {toSelect}
	"self needRebuild: false.
	self buildWithSpec"
]

{ #category : #accessing }
PWBMooseModelBrowser >> highlightAction [
	(self needUpdate: toSelect)
		ifFalse: [ ^ self ].
	modelPresenter selectItem: toSelect
	"self needRebuild: false.
	self buildWithSpec"
]

{ #category : #initialization }
PWBMooseModelBrowser >> initialize [
	super initialize.
	freeze state: true
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializePresenters [
	super initializePresenters.
	model := PWBMooseModelBrowserModel new.
	self initializeTable.
	self initializeSearchField.
	modelPresenter
		whenSelectionChangedDo: [ :selected | 
			model selected: selected selectedItem.
			self freezeDuring: [ self globallySelect: selected selectedItem ] ].
	searchField whenTextIsAcceptedDo: [ :text | self searchFor: text ]
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializeSearchField [
	searchField := self newTextInput
		placeholder: 'Search entities ...';
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
		roots: {model pwbMooseModel};
		children: [ :elt | elt content ];
		beResizable
]

{ #category : #accessing }
PWBMooseModelBrowser >> modelPresenter [
	^ modelPresenter
]

{ #category : #'as yet unclassified' }
PWBMooseModelBrowser >> needUpdate: anEntity [
	^ model selected ~= anEntity
]

{ #category : #initialization }
PWBMooseModelBrowser >> searchFor: aText [
	modelPresenter adapter widget function searchFor: aText
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
