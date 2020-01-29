Class {
	#name : #PWBQueryTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #tests }
PWBQueryTest >> testQueryDeedVariables [
	| query |
	query := QueryDeadVariables runOn: testUserObject1.
	self
		assertCollection: query instanceVariables
		hasSameElements:
			{testInstVar3.
			testInstVar4}.
	self
		assertCollection: query localVariables
		hasSameElements: {testLocalVar3}.
	self assertCollection: query arguments hasSameElements: {testArg1}
]
