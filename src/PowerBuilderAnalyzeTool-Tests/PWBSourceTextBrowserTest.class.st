Class {
	#name : #PWBSourceTextBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBSourceTextBrowserTest >> setUp [
	super setUp.
	browser := PWBSourceTextBrowser new
]
