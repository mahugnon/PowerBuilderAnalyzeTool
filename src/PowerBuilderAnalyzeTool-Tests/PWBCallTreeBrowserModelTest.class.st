Class {
	#name : #PWBCallTreeBrowserModelTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #tests }
PWBCallTreeBrowserModelTest >> testPWBModelIsNotNil [
	self assert: PWBCallTreeBrowserModel new pbModel isNotNil
]

{ #category : #tests }
PWBCallTreeBrowserModelTest >> testSelectedISNotNilWhenAnItemIsSelectedInTheTree [
	pwbCallTreeBrowser setModelPresenterSelection.
	self assert: pwbCallTreeBrowserModel selected isNotNil
]
