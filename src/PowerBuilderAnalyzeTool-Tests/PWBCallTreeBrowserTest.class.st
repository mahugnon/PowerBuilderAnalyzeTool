Class {
	#name : #PWBCallTreeBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#instVars : [
		'browserModel'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBCallTreeBrowserTest >> setUp [
	super setUp.
	browser := PWBCallTreeBrowser new.
browserModel := browser model
]

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserTest >> testApplicationLogsIsEmpty [
	PWBApplication reset.
	self deny: PWBApplication current logger logs isNotEmpty
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testBrowserModelIsNotNil [
	self assert: browser model isNotNil
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testBrowserStatedMustRemainTheSameIffreeze [
browser freeze: true.
browser selectEntity: testUserObject1.
	self deny: browser model selected equals: testUserObject1
]
