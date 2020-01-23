Class {
	#name : #DynamicListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'dynamicPresenter'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-LayerBasePersenters'
}

{ #category : #specs }
DynamicListPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #dynamicPresenter;
		yourself
]

{ #category : #examples }
DynamicListPresenter class >> run [
	<example>
	self new openWithSpec
]

{ #category : #initialization }
DynamicListPresenter >> buildDynamicWindow [
	dynamicPresenter := SpDynamicPresentersListBuilder new
		modelObjects: model;
		presenter: SpListPresenter
			configuredAs: [ :presenter :modelObject | 
			presenter items: modelObject.
			presenter
				whenSelectionChangedDo: [ :selection | 
					model
						add:
							{(selection selectedItem + 1).
							(selection selectedItem + 2).
							(selection selectedItem + 2)}.
					self buildDynamicWindow.
					self needRebuild: false.
					self buildWithSpec ] ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: model size)  ;
		build.
	 
]

{ #category : #initialization }
DynamicListPresenter >> initializePresenter [
	model := {{1 . 2 . 3}.
	{4 . 5 . 6}} asOrderedCollection.
	self buildDynamicWindow
]
