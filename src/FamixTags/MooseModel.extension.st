Extension { #name : #MooseModel }

{ #category : #'*FamixTags' }
MooseModel >> allTags [
	^self privateState attributeAt: #allTags  ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'*FamixTags' }
MooseModel >> futureActionTags [
	FAMIXTag new
		name: 'Obsolette';
		mooseModel: self;
		color: Color red.
	FAMIXTag new
		name: 'Not sure';
		mooseModel: self;
		color: Color yellow.
	FAMIXTag new
		name: 'To be refactored';
		mooseModel: self;
		color: Color orange
]

{ #category : #'*FamixTags' }
MooseModel >> resetTags [
	self allTags do: [ :t | t reset ].
	self privateState attributeAt: #allTags put: OrderedCollection new.
	self futureActionTags
]

{ #category : #'*FamixTags' }
MooseModel >> tagNamed: aString [
	| tags |
	tags := self allTags.
	^ tags
		detect: [ :o | o name = aString ]
		ifNone: [ self error: 'Tag not found' ]
]
