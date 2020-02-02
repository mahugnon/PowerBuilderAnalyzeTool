Class {
	#name : #PWBCallTreeBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'diagramPresenter',
		'obsoletteVarButton',
		'uselessFunctionButton',
		'browseDuplicationButton',
		'zoomInButton',
		'zoomOutButton',
		'hideButton'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #utility }
PWBCallTreeBrowser class >> createIcon [
	ThemeIcons
		compile:
			'callTreeContents
	^ '''
				,
					(Base64MimeConverter
						mimeEncode:
							'/Users/honore/Downloads/function.png' asFileReference
								binaryReadStream) contents , ''''
		classified: '*PWBCodeAnalyser'.
	ThemeIcons
		compile:
			'callGraphIcon
	^ icons
			at: #''callGraphIcon''
			ifAbsentPut:[ Form fromBinaryStream: self callTreeContents base64Decoded asByteArray readStream ]'
		classified: '*PWBCodeAnalyser'.
	Smalltalk ui icons callGraphIcon
]

{ #category : #specs }
PWBCallTreeBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #hideButton;
				add: #browseDuplicationButton;
				add: #uselessFunctionButton;
				add: #obsoletteVarButton;
				add: #zoomInButton;
				add: #zoomOutButton;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #diagramPresenter;
		yourself
]

{ #category : #'as yet unclassified' }
PWBCallTreeBrowser class >> lunchCallTree: aBuilder [
	<worldMenu>
	(aBuilder item: #LaunchPWBCallTree)
		order: 10;
		help:
			'Lauch call Powerbuider methods call tree. You should install a PowerbuilderMooseModel in the image';
		label: 'PWB callTree';
		iconName: #callGraphIcon;
		action: [ self run ]
]

{ #category : #running }
PWBCallTreeBrowser class >> run [
  < example>
  ^self new openWithSpec
]

{ #category : #visiting }
PWBCallTreeBrowser >> accept: anEntity [
	^ true
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeBrowserModel [
	model := PWBCallTreeBrowserModel new.
	model pwbBrowser: self
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeRoassal [
	diagramPresenter := self newLabel.
	diagramPresenter label: 'Visualization here'
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeToolBar [
	obsoletteVarButton := self newButton
		label: 'Browse obsolette Var';
		help: 'Browse non referenced varables';
		iconName: #halt;
		action: [ PWBNonUsedVariableBrowser new
				selectEntity: model selected;
				openWithSpec ].
	uselessFunctionButton := self newButton
		label: 'Browse obsolette Function';
		help: 'Browser non used function.';
		action: [ PWBNonUsedFunctionBrowser lunchOn: model selected ];
		iconName: #glamorousExample;
		yourself.
	browseDuplicationButton := self newButton
		label: 'Browse duplication';
		help: 'Browse duplication between functions.';
		iconName: #duplication;
		action: [ PWBDuplicationBrowser lunchOn: model selected ].
	zoomInButton := self newButton
		label: 'Zoom In';
		icon: (self iconNamed: #glamorousZoomIn);
		action: [ diagramPresenter zoomIn ].
	zoomOutButton := self newButton
		label: 'Zoom Out';
		icon: (self iconNamed: #glamorousZoomOut);
		action: [ diagramPresenter zoomOut ].
	hideButton := self newCheckBox
		label: 'Hide all obsolette';
		help: 'Hide all obsolette element of the view';
		color: Color white;
		yourself
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeWidgets [
	"  menu := self instantiate: CIMMainMenu"

	self initializeBrowserModel.
	self initializeRoassal.
	self initializeToolBar
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		initialExtent: 900 @ 700;
		title: self title
]

{ #category : #'as yet unclassified' }
PWBCallTreeBrowser >> needUpdate: anEntity [
	^ anEntity ~= model selected
]

{ #category : #accessing }
PWBCallTreeBrowser >> selectEntity: anEntity [
	(self needUpdate: anEntity)
		ifFalse: [ ^ self ].
	self model selected: anEntity.
	self updateRoassal
]

{ #category : #accessing }
PWBCallTreeBrowser >> title [
^'Izy view'
]

{ #category : #api }
PWBCallTreeBrowser >> updateRoassal [
	diagramPresenter := self instantiate: model roassal.
	diagramPresenter guiModel: model.
	self needRebuild: false.
	self buildWithSpec
]
