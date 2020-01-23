Class {
	#name : #QueryDuplication,
	#superclass : #AbstractDuplicationQuery,
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-queries'
}

{ #category : #running }
QueryDuplication >> runOn: aCollection [
	^ (DPDetector
		runOn: aCollection
		parametrizedWith:
		(DPParameters new
		minNumberOfLines: 150;
		frequency: 2;
		minNumberOfCharacters: 75;
		cleaner: DPPWBCleaner new))
		setColors;
		fragments
]
