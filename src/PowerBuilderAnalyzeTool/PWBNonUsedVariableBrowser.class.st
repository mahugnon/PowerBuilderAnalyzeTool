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
PWBNonUsedVariableBrowser >> connectPresenters [
	self instAndVarListAction.
	self insVarLocaVarArgListAction
]

{ #category : #initialization }
PWBNonUsedVariableBrowser >> initializeDialogWindow: aDialog [
	super initializeDialogWindow: aDialog.
	aDialog
		initialExtent: 700 @ 400;
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
		sortingBlock: #name ascending;
		enableItemSubstringFilter.
	insVarLocaVarArgList
		display: #name;
		sortingBlock: #name ascending;
		enableItemSubstringFilter.
	functionList
		display: #name;
		sortingBlock: #name ascending;
		enableItemSubstringFilter.
	variableList
		display: #name;
		sortingBlock: #name ascending;
		enableItemSubstringFilter
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowser >> insVarLocaVarArgListAction [
	insVarLocaVarArgList
		transmitTo: functionList
		transform: [ :selectedElement | selectedElement ifNotNil: [ {} ] ]
		postTransmission: [ insVarLocaVarArgList selectIndex: 1 ]
]

{ #category : #accessing }
PWBNonUsedVariableBrowser >> instAndVarList [
	^ instAndVarList
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowser >> instAndVarListAction [
	instAndVarList
		transmitTo: insVarLocaVarArgList
		transform:
			[ :selectedElement | selectedElement ifNotNil: [ model instOrFunctionFor: selectedElement ] ]
		postTransmission: [ "insVarLocaVarArgList selectIndex: 1" ]
]

{ #category : #accessing }
PWBNonUsedVariableBrowser >> selectEntity: anObject [
	model selected: anObject.
	instAndVarList items: model instAndVars
]
