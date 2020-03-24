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
		'validateButton'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

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
	listPresenter := self newList.
	listPresenter
		enableSearch;
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
	listPresenter visibleIf: [ chooseEntity state ]
]

{ #category : #initialization }
OptionPanel >> initializeMaxLevel [
	maxLevel := self newTextInput.
	maxLevel
		autoAccept: true;
		ghostText: 'set max level';
		visibleIf: [ chooseLevel state ]
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
		action: [ self validate ]
]
