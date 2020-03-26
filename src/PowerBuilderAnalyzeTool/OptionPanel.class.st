Class {
	#name : #OptionPanel,
	#superclass : #PWBPresenter,
	#instVars : [
		'possibleEntities',
		'listPresenter',
		'optionParameters',
		'chooseLevel',
		'chooseEntity',
		'maxLevel',
		'validateButton',
		'paramPresenter',
		'cancel'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
OptionPanel class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #chooseLevel;
				add: #chooseEntity;
				yourself)
			withConstraints: [ :constraints | 
				constraints
					height: self toolbarHeight;
					width: self buttonWidth;
					expand: false ];
		add: #paramPresenter;
		add:
			(SpBoxLayout newHorizontal
				add: #validateButton;
				add: #cancel;
				yourself)
			withConstraints: [ :constraints | 
				constraints
					height: self toolbarHeight;
					expand: false ];
		yourself
]

{ #category : #examples }
OptionPanel class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
OptionPanel >> connectPresenters [
	chooseLevel
		whenActivatedDo: [ paramPresenter := maxLevel.
			self needRebuild: false.
			self buildWithSpec ].
	chooseEntity
		whenActivatedDo: [ paramPresenter := listPresenter.
			self needRebuild: false.
			self buildWithSpec ]
]

{ #category : #initialization }
OptionPanel >> initializeChooseButtons [
	chooseLevel := self newRadioButton.
	chooseLevel label: 'Choose level'.
	chooseEntity := self newRadioButton.
	chooseEntity label: 'Choose entity'.
	chooseLevel associatedRadioButtons: {chooseEntity}.
]

{ #category : #initialization }
OptionPanel >> initializeListPresenter [
	listPresenter := self newTable.
	listPresenter
		addColumn:
			((SpCheckBoxTableColumn
				title: ' '
				evaluated: [ :entity | optionParameters selectedEntities includes: entity ])
				onActivation: [ :entity | optionParameters selectEntity: entity ];
				onDesactivation: [ :entity | optionParameters removeEntities: entity ];
				width: 20;
				yourself);
		addColumn: (SpStringTableColumn title: 'Entities' evaluated: #name);
		items: possibleEntities.
	listPresenter enableItemSubstringFilter
]

{ #category : #initialization }
OptionPanel >> initializeMaxLevel [
	maxLevel := self newTextInput.
	maxLevel
		autoAccept: true;
		placeholder: 'set max level'.
]

{ #category : #initialization }
OptionPanel >> initializePresenters [
	possibleEntities := OrderedCollection new.
	optionParameters := OptionParameters new.
	self initializeChooseButtons.
	self initializeListPresenter.
	self initializeMaxLevel.
	validateButton := self newButton.
	validateButton
		label: 'Validate';
		iconName: #smallOk;
		action: [ self validate ].
	cancel := self newButton
		label: 'Close';
		action: [ self window close ];
		iconName: #changeRemove;
		yourself.
	paramPresenter := maxLevel
]

{ #category : #initialization }
OptionPanel >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ self application windowClosed: aWindowPresenter ].
	aWindowPresenter
		title: self title;
		initialExtent: 300 @ 200
]

{ #category : #TOREMOVE }
OptionPanel >> title [ 
^'Options'
]

{ #category : #'private actions' }
OptionPanel >> validate [
	optionParameters
		action:
			({chooseEntity.
			chooseLevel} detect: #state) label;
		maxLevel: maxLevel text asInteger
]
