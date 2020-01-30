Class {
	#name : #PWBNonUsedVariableBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'instAndVarList',
		'insVarLocaVarArgList',
		'functionList',
		'variableList'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #specs }
PWBNonUsedVariableBrowser class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		position: 25 percent;
		add: #instAndVarList;
		add:
			(SpPanedLayout newHorizontal
				position: 25 percent;
				add: #insVarLocaVarArgList;
				add:
					(SpPanedLayout newHorizontal
						position: 40 percent;
						add: #functionList;
						add:
							(SpBoxLayout newVertical
								add: #variableList;
								yourself);
						yourself);
				yourself);
		yourself
]

{ #category : #examples }
PWBNonUsedVariableBrowser class >> example [
	<example>
	self new
		selectEntity:
			((MooseModel root first allWithType: FamixPWBUserObject)
				detect: [ :object | object name endsWith: '_liq_cal' ]);
		openWithSpec
]

{ #category : #initialization }
PWBNonUsedVariableBrowser >> initializeDialogWindow: aDialog [
	super initializeDialogWindow: aDialog.
	aDialog
		initialExtent: 600 @ 400;
		title: 'obsolete variables';
		closeOnBackdropClick: false
]

{ #category : #initialization }
PWBNonUsedVariableBrowser >> initializePresenters [
	model := PWBNonUsedVariableBrowserModel new.
	instAndVarList := self newList.
	insVarLocaVarArgList := self newList.
	functionList := self newList.
	variableList := self newList.
	instAndVarList
		items: model instAndVars;
		display: #name;
		sortingBlock: #name ascending.
	insVarLocaVarArgList
		items: model insVarLocaVarArgs;
		display: #name;
		sortingBlock: #name ascending.
	functionList
		items: model functions;
		display: #name;
		sortingBlock: #name ascending.
	variableList
		items: model variables;
		display: #name;
		sortingBlock: #name ascending.
	self focusOrder
		add: instAndVarList;
		add: insVarLocaVarArgList;
		add: functionList
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowser >> instAndVarListAction [
	instAndVarList
		transmitTo: insVarLocaVarArgList
		transform:
			[ :selectedElement | selectedElement ifNotNil: [ model instOrVarFor: selectedElement ] ]
		postTransmission: [ insVarLocaVarArgList selectIndex: 1 ]
]

{ #category : #accessing }
PWBNonUsedVariableBrowser >> selectEntity: anObject [
	model selected: anObject
]
