!classDefinition: #I category: 'Numeros-Romanos'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Romanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros-Romanos'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next' stamp: 'ARM 3/31/2022 21:18:47'!
next

	^II! !


!I class methodsFor: 'operations' stamp: 'FM 4/5/2022 09:44:20'!
* multiplicando

	^multiplicando! !

!I class methodsFor: 'operations' stamp: 'FM 4/5/2022 09:40:47'!
+ sumando

	^sumando next! !

!I class methodsFor: 'operations' stamp: 'mf 4/11/2022 04:45:52'!
- unSustraendo

	
	self error: I negativeNumbersNotSupportedErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'mf 4/11/2022 05:31:45'!
/ unDivisor

	self = unDivisor ifTrue: [^self].
	
	self error: II canNotDivideByBiggerNumberErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'mf 4/11/2022 05:29:06'!
esMayorQue: unNumeroRomano
	^false! !

!I class methodsFor: 'operations' stamp: 'mf 4/11/2022 04:44:03'!
negativeNumbersNotSupportedErrorDescription
	^'Negative numbers not supported'! !

!I class methodsFor: 'operations' stamp: 'FM 4/5/2022 09:43:55'!
sustraerA: minuendo

	^minuendo previous! !


!classDefinition: #II category: 'Numeros-Romanos'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Romanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros-Romanos'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones' stamp: 'FM 4/5/2022 09:47:10'!
* multiplicando

	^multiplicando + (previous * multiplicando)! !

!II class methodsFor: 'operaciones' stamp: 'FM 4/5/2022 09:45:54'!
+ sumando

	^previous + sumando next! !

!II class methodsFor: 'operaciones' stamp: 'FM 4/5/2022 09:42:51'!
- sustraendo

	^sustraendo sustraerA: self! !

!II class methodsFor: 'operaciones' stamp: 'mf 4/11/2022 05:32:38'!
/ unDivisor
	
	(unDivisor esMayorQue: self) ifTrue:[self error: II canNotDivideByBiggerNumberErrorDescription].
	
	self = unDivisor ifTrue: [^I].
	
	^ I + ((self-unDivisor)/unDivisor)! !

!II class methodsFor: 'operaciones' stamp: 'mf 4/11/2022 05:22:45'!
canNotDivideByBiggerNumberErrorDescription
	
	^'Can noy divide by bigger number'! !

!II class methodsFor: 'operaciones' stamp: 'mf 4/11/2022 05:28:55'!
esMayorQue: unNumeroRomano

	self previous = unNumeroRomano ifTrue: [^true].
	^self previous esMayorQue: unNumeroRomano! !

!II class methodsFor: 'operaciones' stamp: 'FM 4/5/2022 09:43:31'!
sustraerA: minuendo

	^minuendo previous - (self previous)! !


!II class methodsFor: 'next & previous' stamp: 'FM 4/5/2022 10:07:55'!
next
	next ifNotNil:[^next].
	next _ II createChildNamed: self nombrarNext.
	next previous: self.
	^next! !

!II class methodsFor: 'next & previous' stamp: 'mf 4/11/2022 04:10:53'!
nombrarNext

	(self name endsWith: 'CMXCIX') ifTrue: [^(self name withoutSuffix: 'CMXCIX') , 'M'].

	(self name endsWith: 'DCCCXCIX') ifTrue: [^(self name withoutSuffix: 'DCCCXCIX') , 'CM'].

	(self name endsWith: 'CDXCIX') ifTrue: [^(self name withoutSuffix: 'CDXCIX') , 'D'].

	(self name endsWith: 'CCCXCIX') ifTrue: [^(self name withoutSuffix: 'CCCXCIX') , 'CD'].
	
	(self name endsWith: 'XCIX') ifTrue: [^(self name withoutSuffix: 'XCIX') , 'C'].
	
	(self name endsWith: 'LXXXIX') ifTrue: [^(self name withoutSuffix: 'LXXXIX') , 'XC'].
	
	(self name endsWith: 'XLIX') ifTrue: [^(self name withoutSuffix: 'XLIX') , 'L'].
	
	(self name endsWith: 'XXXIX') ifTrue: [^(self name withoutSuffix: 'XXXIX') , 'XL'].
	
	(self name endsWith: 'IX') ifTrue: [^(self name withoutSuffix: 'IX') , 'X'].
	
	(self name endsWith: 'VIII') ifTrue: [^(self name withoutSuffix: 'VIII') , 'IX'].
	
	(self name endsWith: 'IV') ifTrue: [^(self name withoutSuffix: 'IV') , 'V'].
	
	(self name endsWith: 'III') ifTrue: [^(self name withoutSuffix: 'III') , 'IV'].
	
	^self name , 'I'
	! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:26:45'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:55'!
previous: unNatural 
	
	previous _ unNatural! !


!II class methodsFor: 'as yet unclassified' stamp: 'mf 4/11/2022 05:33:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros-Romanos'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Romanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros-Romanos'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'mf 4/11/2022 05:33:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'Numeros-Romanos'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Romanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Numeros-Romanos'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: 'as yet unclassified' stamp: 'mf 4/11/2022 05:33:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := V.
	previous := III.! !


!classDefinition: #V category: 'Numeros-Romanos'!
II subclass: #V
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Romanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'V class' category: 'Numeros-Romanos'!
V class
	instanceVariableNames: ''!

!V class methodsFor: 'as yet unclassified' stamp: 'mf 4/11/2022 05:33:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VI.
	previous := IV.! !


!classDefinition: #VI category: 'Numeros-Romanos'!
II subclass: #VI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Romanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VI class' category: 'Numeros-Romanos'!
VI class
	instanceVariableNames: ''!

!VI class methodsFor: 'as yet unclassified' stamp: 'mf 4/11/2022 05:33:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VII.
	previous := V.! !


!classDefinition: #VII category: 'Numeros-Romanos'!
II subclass: #VII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Romanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VII class' category: 'Numeros-Romanos'!
VII class
	instanceVariableNames: ''!

!VII class methodsFor: 'as yet unclassified' stamp: 'mf 4/11/2022 05:33:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VIII.
	previous := VI.! !


!classDefinition: #VIII category: 'Numeros-Romanos'!
II subclass: #VIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Romanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VIII class' category: 'Numeros-Romanos'!
VIII class
	instanceVariableNames: ''!

!VIII class methodsFor: 'as yet unclassified' stamp: 'mf 4/11/2022 05:33:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := VII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
V initializeAfterFileIn!
VI initializeAfterFileIn!
VII initializeAfterFileIn!
VIII initializeAfterFileIn!