Class {
	#name : #PWBDuplicationBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'entityPanel',
		'sourceCodePanel',
		'model',
		'duplicationResultPanel',
		'duplicationViewSelector',
		'minNumberOfLinesTextInput',
		'minNumberOfCharactersInput'
	],
	#classInstVars : [
		'colorMap'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #private }
PWBDuplicationBrowser class >> createIcon [
	ThemeIcons
		compile:
			'duplicationIcon
	^ '''
				,
					(Base64MimeConverter
						mimeEncode:
							'/Users/honore/Documents/Resources/duplicate.png' asFileReference
								binaryReadStream) contents , ''''
		classified: '*DuplicationGUI'.
	ThemeIcons
		compile:
			'duplication
	^ icons
			at: #''duplication''
			ifAbsentPut:[ Form fromBinaryStream: self duplicationIcon base64Decoded asByteArray readStream ]'
		classified: 'DuplicationGUI'.
	Smalltalk ui icons duplication
]

{ #category : #specs }
PWBDuplicationBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		add:
			(SpBoxLayout newVertical
				add:
					(SpBoxLayout newHorizontal
						add: #entityPanel
							withConstraints: [ :constraints | constraints width: 300 ];
						add:
							(SpBoxLayout newVertical
								add: #duplicationViewSelector
									withConstraints: [ :constraints | constraints height: self toolbarHeight ];
								add: #duplicationResultPanel;
								yourself);
						yourself);
				add:
					(SpBoxLayout newHorizontal
						add: #minNumberOfLinesTextInput;
						add: #minNumberOfCharactersInput;
						yourself)
					withConstraints: [ :constraints | constraints height: self toolbarHeight ];
				yourself);
		add: #sourceCodePanel;
		yourself
]

{ #category : #'as yet unclassified' }
PWBDuplicationBrowser class >> duplicationView: aBuilder [
	<worldMenu>
	self createIcon.
	(aBuilder item: #Duplication)
		order: 10;
		help:
			'Lauch call Powerbuider methods call tree. You should install a PowerbuilderMooseModel in the image';
		label: 'PWB Duplication';
		iconName: #duplication;
		action: [ self runMe ]
]

{ #category : #'as yet unclassified' }
PWBDuplicationBrowser class >> lunchOn: anObject [
	self basicNew
		initializeModel;
		mooseModel: anObject;
		initialize;
		openWithSpec;
		selectFirstItem
]

{ #category : #examples }
PWBDuplicationBrowser class >> runMe [
  < example>
  self new openWithSpec
]

{ #category : #specs }
PWBDuplicationBrowser class >> title [
^'Code duplication browser '
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeDuplicationResultPanel [
	duplicationResultPanel := self instantiate: model defaultRoassalView.
	duplicationResultPanel model: model
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeDuplicationRoassalViewSelector [
	duplicationViewSelector := self newDropList.
	duplicationViewSelector
		items: DuplicationBrowserRoassalView views;
		help: 'Select the roassal visualization to use';
		display: [ :item | item viewName ]
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeEntityPanel [
	entityPanel := self newList.
	entityPanel items: {model mooseModelFunctions}
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeMinNumberOfCharactersInput [
	minNumberOfCharactersInput := self
		instantiate:
			(SpLabelledPresenter
				label: 'Min character: '
				input:
					(self newTextInput
						autoAccept: true;
						placeholder: 'Fill the minimum character of dupplicated lines to return';
						text: self minNumberOfCharacters asString))
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeMinNumberOfLinesTextInput [
	minNumberOfLinesTextInput := self
		instantiate:
			(SpLabelledPresenter
				label: 'Min line: '
				input:
					(self newTextInput
						autoAccept: true;
						placeholder: 'Fill the minimum number of dupplicated lines to return';
						text: self minNumberOfLines asString))
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeModel [
	model := DuplicationBrowserModel new.
	model duplicationBrowser: self
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializePresenter [
	super initializePresenter.
	entityPanel
		whenSelectionChangedDo: [ :selection | model computeDuplicationWith: selection selectedItem ].
	minNumberOfLinesTextInput
		whenTextChangedDo: [ :aText | model minNumberOfLines: aText asInteger ].
	minNumberOfCharactersInput
		whenTextChangedDo: [ :aText | model minNumberOfCharacters: aText asInteger ]
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeSourceCodePanel [
	sourceCodePanel := self instantiate: SourceTextPresenter.
	self iconNamed: #duplication
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeWidgets [
	super initializeWidgets.
	"self initializeModel."
	self initializeEntityPanel.
	self initializeDuplicationResultPanel.
	self initializeSourceCodePanel.
	self initializeDuplicationRoassalViewSelector.
	self initializeMinNumberOfLinesTextInput.
	self initializeMinNumberOfCharactersInput
]

{ #category : #accessing }
PWBDuplicationBrowser >> minNumberOfCharacters [
	^ model minNumberOfCharacters
]

{ #category : #accessing }
PWBDuplicationBrowser >> minNumberOfCharactersInput [
	^ minNumberOfCharactersInput
]

{ #category : #accessing }
PWBDuplicationBrowser >> minNumberOfLines [
	^ model minNumberOfLines
]

{ #category : #acessing }
PWBDuplicationBrowser >> minNumberOfLinesTextInput [
	^ minNumberOfLinesTextInput
]

{ #category : #accessing }
PWBDuplicationBrowser >> mooseModel: aFamixPWBUserObject [
	model mooseModel: aFamixPWBUserObject.
	self initializeEntityPanel
]

{ #category : #accessing }
PWBDuplicationBrowser >> selectEntity: anEntity [
	model selected: anEntity
]

{ #category : #'event handling' }
PWBDuplicationBrowser >> selectFirstItem [
	entityPanel selectItem: entityPanel items first
]

{ #category : #updating }
PWBDuplicationBrowser >> updateCode [
	sourceCodePanel text: model fragmentText.
	sourceCodePanel entityName: model selectedFragmentLocationName
]
