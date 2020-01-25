Class {
	#name : #PWBCallTreeBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #tests }
PWBCallTreeBrowserTest >> testBrowserModelIsNotNil [
	self assert: pwbCallTreeBrowser model isNotNil
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testSelectedItemIsNotNil [
	pwbCallTreeBrowser setModelPresenterSelection.
	self assert: pwbCallTreeBrowser modelPresenter selectedItem isNotNil
]
