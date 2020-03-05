Class {
	#name : #PWBTagForm,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'entity',
		'tagsList',
		'newTagName',
		'colorPalete',
		'newTagForm',
		'addNewTag'
	],
	#category : #PowerBuilderAnalyzeTool
}

{ #category : #specs }
PWBTagForm class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #tagsList;
				add: #addNewTag;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #newTagForm;
		yourself
]

{ #category : #examples }
PWBTagForm class >> runMe [
	<script>
	self new open
]

{ #category : #visiting }
PWBTagForm >> accept: anObject [
	^ true
]

{ #category : #initialization }
PWBTagForm >> connectPresenters [
	addNewTag
		whenChangedDo: [ self needRebuild: false.
			self buildWithSpec ]
]

{ #category : #initialization }
PWBTagForm >> initializePresenters [
	addNewTag := self newCheckBox.
	addNewTag label: 'Add new  tag'.
	addNewTag state: false.
	tagsList := self instantiate: SpLabelledDropList.
	tagsList label: 'Select a Tag: '.
	tagsList dropList display: #name.
	newTagForm := self instantiate: PWBNewTagForm.
	newTagForm visibleIf: [ addNewTag state ]
]

{ #category : #'instance creation' }
PWBTagForm >> open [
	self openDialogWithSpec
		okAction: [ tagsList dropList selectedItem ifNil: [ ^ self ].
			entity addTag: tagsList dropList selectedItem ]
]

{ #category : #accessing }
PWBTagForm >> selectEntity: anEntity [
	entity := anEntity.
	tagsList items: entity mooseModel allTags
]
