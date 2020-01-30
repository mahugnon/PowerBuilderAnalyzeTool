Class {
	#name : #PWBNonUsedVariableBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'instAndVarList',
		'variableList',
		'attributOrBehaviorList',
		'variableTypeList'
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
				add: #attributOrBehaviorList;
				add:
					(SpPanedLayout newHorizontal
						position: 40 percent;
						add: #variableTypeList;
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

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowser >> attributOrBehaviorListAction [
	attributOrBehaviorList
		transmitTo: variableTypeList
		transform: [ :selectedElement | 
			selectedElement
				ifNotNil: [ (selectedElement name beginsWith: 'i')
						ifTrue: [ {} ]
						ifFalse: [ model focusVariables: selectedElement ] ] ]
		postTransmission: [ variableTypeList model items
				ifNotEmpty: [ variableTypeList selectIndex: 1 ] ]
]

{ #category : #initialization }
PWBNonUsedVariableBrowser >> connectPresenters [
	self instAndVarListAction.
	self attributOrBehaviorListAction.
	self variableTypeListAction
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
	attributOrBehaviorList := self newList.
	variableTypeList := self newList.
	variableList := self newList.
	instAndVarList
		items: model instAndVars;
		display: #name;
		sortingBlock: #name ascending;
		enableItemSubstringFilter.
	attributOrBehaviorList
		display: #name;
		sortingBlock: #name ascending;
		enableItemSubstringFilter.
	variableList
		display: #name;
		sortingBlock: #name ascending;
		enableItemSubstringFilter.
	variableTypeList enableItemSubstringFilter
]

{ #category : #accessing }
PWBNonUsedVariableBrowser >> instAndVarList [
	^ instAndVarList
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowser >> instAndVarListAction [
	instAndVarList
		transmitTo: attributOrBehaviorList
		transform:
			[ :selectedElement | selectedElement ifNotNil: [ model instOrFunctionFor: selectedElement ] ]
		postTransmission: [ attributOrBehaviorList selectIndex: 1 ]
]

{ #category : #accessing }
PWBNonUsedVariableBrowser >> selectEntity: anObject [
	model selected: anObject.
	instAndVarList items: model instAndVars
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowser >> variableTypeListAction [
	variableTypeList
		transmitTo: variableList
		transform:
			[ :selectedElement | selectedElement ifNotNil: [ model focusVariablesFor: selectedElement ] ]
		postTransmission: [ variableList selectIndex: 1 ]
]
