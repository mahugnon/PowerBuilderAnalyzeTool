Class {
	#name : #PWBCallTreeBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'modelPresenter',
		'diagramPresenter',
		'model',
		'searchField',
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
	^ SpPanedLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #searchField
					withConstraints: [ :constraints | constraints height: self toolbarHeight ];
				add: #modelPresenter;
				yourself);
		add:
			(SpBoxLayout newVertical
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
				yourself);
		" add: #menu withConstraints: [:constraints |  constraints height: self toolbarHeight ];"
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

{ #category : #'as yet unclassified' }
PWBCallTreeBrowser class >> title [
^'Izy view'
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeBrowserModel [
	model := PWBCallTreeBrowserModel new.
	model pwbBrowser: self
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializePresenters [
	modelPresenter
		whenSelectionChangedDo: [ :selected | 
			model selected: selected selectedItem.
			self updateWithSelection.
			self globallySelect: selected selectedItem ].
	searchField
		whenTextIsAcceptedDo: [ :text | modelPresenter searchFor: text ]
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeRoassal [
	diagramPresenter := self newLabel.
	diagramPresenter label: 'Visualization here'
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeTable [
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
PWBCallTreeBrowser >> initializeToolBar [
	obsoletteVarButton := self newButton
		label: 'Browse obsolette Var';
		help: 'Browse non referenced varables';
		iconName: #halt.
	uselessFunctionButton := self newButton
		label: 'Browse obsolette Function';
		help: 'Browser non used function.';
		action: [ self inform: 'Browser non used function' ];
		iconName: #glamorousExample;
		yourself.
	browseDuplicationButton := self newButton
		label: 'Browse duplication';
		help: 'Browse duplication between functions.';
		iconName: #duplication.
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
	self initializeTable.
	searchField := self newTextInput
		placeholder: 'rechercher dans le model ...';
		yourself.
	searchField acceptOnCR: true.
	self initializeRoassal.
	self initializeToolBar
]

{ #category : #accessing }
PWBCallTreeBrowser >> model [
	^ model
]

{ #category : #accessing }
PWBCallTreeBrowser >> modelPresenter [
	^ modelPresenter
]

{ #category : #accessing }
PWBCallTreeBrowser >> selectEntity: anEntity [
	self model globallySelected: anEntity
]

{ #category : #'as yet unclassified' }
PWBCallTreeBrowser >> updateRoassal [
  diagramPresenter := self instantiate: model roassal.
  diagramPresenter guiModel: model.
  self needRebuild: false.
  self buildWithSpec
  "self
		instantiatePresenters:
			{#diagramPresenter.
			model roassal name asSymbol}.
	diagramPresenter pbModel: model selected content."
]

{ #category : #api }
PWBCallTreeBrowser >> updateWithSelection [
	self updateRoassal
]
