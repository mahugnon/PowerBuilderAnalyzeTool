Class {
	#name : #PWBQueryTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBQueryTest >> setUp [
	pwbCallTreeBrowser := PWBCallTreeBrowser new.
	pwbCallTreeBrowserModel := pwbCallTreeBrowser model.
	testModel := FamixPWBModel new.
	self initializeTestUserObject.
	self initializeTestFunctions.
	self initializeVariables.
	self initializeAccess
]

{ #category : #tests }
PWBQueryTest >> testQueryDeadArguments [
	self
		assertCollection:
			(QueryDeadArguments
				runOn:
					{testLocalVar3.
					testArg1})
		hasSameElements: {testArg1}
]

{ #category : #tests }
PWBQueryTest >> testQueryDeadLocalVariables [
	self
		assertCollection:
			(QueryDeadLocalVariables
				runOn:
					{testLocalVar3.
					testArg1})
		hasSameElements: {testLocalVar3}
]

{ #category : #tests }
PWBQueryTest >> testQueryDeadVariablesBehavioral [
	| behavioral |
	behavioral := QueryBehavioral
		runOn:
			{testLocalVar3.
			testArg1}.
	self
		assertCollection: behavioral
		hasSameElements:
			{testFunction1.
			testFunction2}.
	self assert: testFunction1 deadArguments anyOne equals: testArg1.
	self assert: testFunction1 deadLocalVariables isEmpty
]

{ #category : #tests }
PWBQueryTest >> testQueryDeedAttributesVariables [
	| query |
	query := QueryDeadVariables runOn: testUserObject1.
	self
		assertCollection: query instanceVariables
		hasSameElements:
			{testInstVar3.
			testInstVar4}
]

{ #category : #tests }
PWBQueryTest >> testQueryDeedVariables [
	| query |
	query := QueryDeadVariables runOn: testUserObject1.
	self
		assertCollection: query variables
		hasSameElements:
			{testLocalVar3.
			testArg1}
]
