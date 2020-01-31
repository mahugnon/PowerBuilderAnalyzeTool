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
		position: 30 percent;
		add: #instAndVarList;
		add:
			(SpPanedLayout newHorizontal
				position: 70 percent;
				add: #attributOrBehaviorList;
				add: #variableTypeList;
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
		whenSelectionChangedDo: [ :item | 
			item selectedItem ifNil: [ ^ self ].
			(item selectedItem name beginsWith: 'i')
				ifTrue: [ {} ]
				ifFalse: [ | dic |
					dic := model focusVariables: item selectedItem.
					variableTypeList
						roots: dic keys;
						children: [ :elt | dic at: elt ifAbsent: [ #() ] ] ] ]
]

{ #category : #initialization }
PWBNonUsedVariableBrowser >> connectPresenters [
	self instAndVarListAction.
	self attributOrBehaviorListAction
	"self variableTypeListAction"
]

{ #category : #initialization }
PWBNonUsedVariableBrowser >> initializePresenters [
	model := PWBNonUsedVariableBrowserModel new.
	instAndVarList := self newList.
	attributOrBehaviorList := self newList.
	variableTypeList := self newTreeTable .
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
"	variableTypeList enableItemSubstringFilter"
]

{ #category : #initialization }
PWBNonUsedVariableBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		initialExtent: 700 @ 400;
		title: 'Obsolete Variables Browser'
	"	closeOnBackdropClick: false"
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
