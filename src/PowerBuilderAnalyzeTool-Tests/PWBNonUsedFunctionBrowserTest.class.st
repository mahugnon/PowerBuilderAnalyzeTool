Class {
	#name : #PWBNonUsedFunctionBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#instVars : [
		'browser'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBNonUsedFunctionBrowserTest >> setUp [
	super setUp.
	browser := PWBNonUsedFunctionBrowser new
]

{ #category : #asserting }
PWBNonUsedFunctionBrowserTest >> shouldNotUpdateOnMooseGroup [
	| group |
	group := {testUserObject1.
	testUserObject2} asMooseGroup.
	browser selectEntity: group.
	self deny: browser selected equals: group
]
