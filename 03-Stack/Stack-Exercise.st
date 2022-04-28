!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'mf 4/28/2022 08:04:07'!
test01SentencedFoundShouldBeEmptyIfNotSentenceWithPrefixFound
	
	|stackOraciones prefijo|
	
	prefijo _ 'sum'.
	
	stackOraciones _ (OOStack new push: 'Winter') push:'winter'.
	
	self assert: 	((SentenceFinderByPrefix new withStack: stackOraciones) find: prefijo) isEmpty
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'VV 9/17/2021 19:12:11'!
test02SentencedFoundShouldBeSizeOfSentencesWithPrefix
	|stackOraciones prefijo|
	prefijo:= 'win'.
	stackOraciones := (OOStack new push: 'Winter') push:'winter'.
	self assert: 	(((SentenceFinderByPrefix new withStack: stackOraciones) find: prefijo) size = 1)
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'VV 9/19/2021 14:31:01'!
test03SentencedFoundShouldBeInSameOrderAnWithPrefix
	|stackOraciones prefijo|
	prefijo:= 'win'.
	stackOraciones := ((OOStack new push: 'win') push: 'winter') push:'Winter'.	
	self assert: 	(((SentenceFinderByPrefix new withStack: stackOraciones) find: prefijo) last = 'winter').
	self assert: 	(((SentenceFinderByPrefix new withStack: stackOraciones) find: prefijo) first = 'win')
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'VV 9/19/2021 14:33:04'!
test04SentencedFinderDoesNotChangeTheStack
	|stackOraciones prefijo|
	prefijo:= 'win'.
	stackOraciones := ((OOStack new push: 'win') push: 'Winter') push: 'winter'.	
	(SentenceFinderByPrefix new withStack: stackOraciones) find: prefijo.	
	self assert: stackOraciones pop = 'winter'.
	self assert: stackOraciones pop = 'Winter'.
	self assert: stackOraciones pop = 'win'.
	self assert: stackOraciones isEmpty.
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'VV 9/19/2021 14:31:34'!
test05prefixCanNotBeBlank
	|stackSentences prefix|
	prefix:= ''.
	stackSentences := ((OOStack new push: 'win') push: 'Winter') push: 'winter'.	
	
	self
		should: [(SentenceFinderByPrefix new withStack: stackSentences) find: prefix. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixBlankErrorDescription ]
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'VV 9/19/2021 14:33:37'!
test06prefixCanNotHaveSpaces
	|stackSentences prefix|
	prefix:= 'Winter is'.
	stackSentences := ((OOStack new push: 'win') push: 'Winter') push: 'winter'.	
	
	self
		should: [(SentenceFinderByPrefix new withStack: stackSentences) find: prefix. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixHaveSpacesErrorDescription ]
	
	
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'Initialization' stamp: 'mf 4/28/2022 08:02:20'!
initialize
	
	top _ OOEmptyStackTop new.
	
	elements _ OrderedCollection new.! !


!OOStack methodsFor: 'checks' stamp: 'mf 4/28/2022 06:56:45'!
isEmpty
	
	^elements isEmpty.! !

!OOStack methodsFor: 'checks' stamp: 'mf 4/28/2022 06:57:03'!
size
	
	^elements size.! !

!OOStack methodsFor: 'checks' stamp: 'mf 4/28/2022 07:27:07'!
top
	
	^top value.! !


!OOStack methodsFor: 'modify' stamp: 'mf 4/28/2022 07:56:20'!
pop
	
	^ top canPopFrom: self.
    	
	! !

!OOStack methodsFor: 'modify' stamp: 'mf 4/28/2022 08:02:38'!
push: anElement

	elements addLast: anElement.
	
	top _ OONotEmptyStackTop withValue: anElement
	! !


!OOStack methodsFor: 'private' stamp: 'mf 4/28/2022 07:04:07'!
elements
	
	^elements! !

!OOStack methodsFor: 'private' stamp: 'mf 4/28/2022 07:54:51'!
removeTop
	
	elements removeLast.
	
	top _ OOStackTop of: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackTop category: 'Stack-Exercise'!
Object subclass: #OOStackTop
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTop methodsFor: 'access' stamp: 'mf 4/28/2022 06:59:34'!
value
	
	self subclassResponsibility! !


!OOStackTop methodsFor: 'check' stamp: 'mf 4/28/2022 07:57:17'!
canPopFrom: anOOStack
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackTop class' category: 'Stack-Exercise'!
OOStackTop class
	instanceVariableNames: ''!

!OOStackTop class methodsFor: 'as yet unclassified' stamp: 'mf 4/28/2022 07:05:49'!
canHandle: anOOStack
	
	self subclassResponsibility! !

!OOStackTop class methodsFor: 'as yet unclassified' stamp: 'mf 4/28/2022 07:16:56'!
of: anOOStack

	^(self subclasses detect:[:subclass| subclass canHandle: anOOStack]) for: anOOStack.
	
	! !


!classDefinition: #OOEmptyStackTop category: 'Stack-Exercise'!
OOStackTop subclass: #OOEmptyStackTop
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyStackTop methodsFor: 'check' stamp: 'mf 4/28/2022 07:57:17'!
canPopFrom: anOOStack

	self error: OOStack stackEmptyErrorDescription
	
	! !


!OOEmptyStackTop methodsFor: 'access' stamp: 'mf 4/28/2022 07:00:19'!
value 
	
	self error: OOStack stackEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOEmptyStackTop class' category: 'Stack-Exercise'!
OOEmptyStackTop class
	instanceVariableNames: ''!

!OOEmptyStackTop class methodsFor: 'as yet unclassified' stamp: 'mf 4/28/2022 07:06:44'!
canHandle: anOOStack
	
	^anOOStack isEmpty.! !

!OOEmptyStackTop class methodsFor: 'as yet unclassified' stamp: 'mf 4/28/2022 08:01:55'!
for: anOOStack

	^self new	! !


!classDefinition: #OONotEmptyStackTop category: 'Stack-Exercise'!
OOStackTop subclass: #OONotEmptyStackTop
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONotEmptyStackTop methodsFor: 'private' stamp: 'mf 4/28/2022 07:11:54'!
initializeWith: anObject

	value _ anObject! !


!OONotEmptyStackTop methodsFor: 'access' stamp: 'mf 4/28/2022 07:01:25'!
value
	
	^value! !


!OONotEmptyStackTop methodsFor: 'checks' stamp: 'mf 4/28/2022 07:57:17'!
canPopFrom: anOOStack
	
	anOOStack removeTop.
	
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONotEmptyStackTop class' category: 'Stack-Exercise'!
OONotEmptyStackTop class
	instanceVariableNames: ''!

!OONotEmptyStackTop class methodsFor: 'as yet unclassified' stamp: 'mf 4/28/2022 07:07:23'!
canHandle: anOOStack
	
	^anOOStack isEmpty not.! !

!OONotEmptyStackTop class methodsFor: 'as yet unclassified' stamp: 'mf 4/28/2022 07:17:22'!
for: anOOStack
	
	^ self new initializeWith: (anOOStack elements last).! !

!OONotEmptyStackTop class methodsFor: 'as yet unclassified' stamp: 'mf 4/28/2022 07:25:59'!
withValue: anObject
	
	^self new initializeWith: anObject! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'originalStack reversedOrderStack sentencesFound'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'enumerating' stamp: 'mf 4/28/2022 08:35:38'!
find: aPrefix
	
	self checkIfAPrefixIsValid: aPrefix.
	
	self findSentencesStartedWith: aPrefix.		
				
	^sentencesFound
	
	! !


!SentenceFinderByPrefix methodsFor: 'checks' stamp: 'mf 4/28/2022 08:24:43'!
areSentencesRemaining

	^ originalStack isEmpty not.
	
	! !

!SentenceFinderByPrefix methodsFor: 'checks' stamp: 'mf 4/28/2022 08:28:30'!
checkIfAPrefixIsValid: aPrefix

	(aPrefix = '') ifTrue:[self error: SentenceFinderByPrefix prefixBlankErrorDescription].
	
	((aPrefix findString: ' ') > 0) ifTrue:[self error: SentenceFinderByPrefix prefixHaveSpacesErrorDescription]! !


!SentenceFinderByPrefix methodsFor: 'modify' stamp: 'mf 4/28/2022 08:46:40'!
findSentencesStartedWith: aPrefix
	
	[self areSentencesRemaining] 
	whileTrue:[
			self saveTheTopOfTheStackIfItStartsWith: aPrefix.
			self removeTopOfTheStackAndSaveIt.	
		].
		
	self returnTheStackToItsOriginalValue.
				
	^sentencesFound
	
	! !

!SentenceFinderByPrefix methodsFor: 'modify' stamp: 'mf 4/28/2022 08:42:59'!
removeTopOfTheStackAndSaveIt

	reversedOrderStack push: originalStack pop.
	
	! !

!SentenceFinderByPrefix methodsFor: 'modify' stamp: 'mf 4/28/2022 08:46:07'!
returnTheStackToItsOriginalValue

	[reversedOrderStack isEmpty not]
	whileTrue:[
		originalStack push: reversedOrderStack pop.
		]
	
	! !

!SentenceFinderByPrefix methodsFor: 'modify' stamp: 'mf 4/28/2022 08:41:09'!
saveTheTopOfTheStackIfItStartsWith: aPrefix

	(originalStack top beginsWith: aPrefix) ifTrue:[sentencesFound addFirst: (originalStack top)].! !

!SentenceFinderByPrefix methodsFor: 'modify' stamp: 'mf 4/28/2022 08:21:01'!
withStack: anStack
	
	originalStack _ anStack. 
	reversedOrderStack _ OOStack new.
	sentencesFound _ OrderedCollection new
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'VV 9/17/2021 19:25:24'!
prefixBlankErrorDescription
	^'prefix can not be blank'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'VV 9/17/2021 19:27:30'!
prefixHaveSpacesErrorDescription
	^'prefix can not have spaces'! !
