Class {
	#name : #PWBMooseModelBrowser1,
	#superclass : #PWBMooseModelBrowser,
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #initialization }
PWBMooseModelBrowser1 >> initializeTable [
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
		roots: {model pwbMooseModel};
		children: [ :elt | elt children ];
		beResizable
]
