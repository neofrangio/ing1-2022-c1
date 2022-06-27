!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests'!
test01Import
	CustomerImporter
		valueFrom: self validImportData
		into: session.
	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly.! !

!ImportTest methodsFor: 'tests'!
test02ImportEmptyDataRaiseError
	self
		should: [
			CustomerImporter
				valueFrom: self emptyImportData
				into: session ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :argm0_1 |
			self
				assert: CustomerImporter dataSourceIsEmptyErrorMessageText
				equals: argm0_1 messageText.
			self assert: (session selectAllOfType: Customer) isEmpty ].! !

!ImportTest methodsFor: 'tests'!
test03sourceMustStartWithClient
	self
		should: [
			CustomerImporter
				valueFrom: self addressFirstData
				into: session ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :argm0_1 |
			self
				assert: CustomerImporter dataDoesNotStartWithCustomerPersonalData
				equals: argm0_1 messageText.
			self assert: (session selectAllOfType: Customer) isEmpty ].! !

!ImportTest methodsFor: 'tests'!
test04customerDataMustBeComplete
	self
		should: [
			CustomerImporter
				valueFrom: self customerMissingOneFieldOfData
				into: session ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :argm0_1 |
			self
				assert: CustomerImporter customerMissingFieldErrorDescription
				equals: argm0_1 messageText ].! !

!ImportTest methodsFor: 'tests'!
test05addressDataMustBeComplete
	self
		should: [
			CustomerImporter
				valueFrom: self addressMisingFieldOfData
				into: session ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :argm0_1 |
			self
				assert: CustomerImporter addressMissingFieldErrorDescription
				equals: argm0_1 messageText ].! !

!ImportTest methodsFor: 'tests'!
test06customerHasDataOverflow
	self
		should: [
			CustomerImporter
				valueFrom: self customerWithAnAdditionalField
				into: session ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :argm0_1 |
			self
				assert: CustomerImporter customerWithAnAdditionalFieldErrorDescription
				equals: argm0_1 messageText ].! !

!ImportTest methodsFor: 'tests'!
test07addressHasDataOverflow
	self
		should: [
			CustomerImporter
				valueFrom: self addressWithAnAdditionalField
				into: session ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :argm0_1 |
			self
				assert: CustomerImporter addressWithAnAdditionalFieldError
				equals: argm0_1 messageText ].! !


!ImportTest methodsFor: 'assertions'!
assertAddressOf: arg1 at: arg2 hasNumber: arg3 town: arg4 zipCode: arg5 province: arg6
	| temp7 |
	temp7 _ arg1
		addressAt: arg2
		ifNone: [ self fail ].
	self
		assert: arg2
		equals: temp7 streetName.
	self
		assert: arg3
		equals: temp7 streetNumber.
	self
		assert: arg4
		equals: temp7 town.
	self
		assert: arg5
		equals: temp7 zipCode.
	self
		assert: arg6
		equals: temp7 province.! !

!ImportTest methodsFor: 'assertions'!
assertCustomerWithIdentificationType: arg1 number: arg2 hasFirstName: arg3 lastName: arg4
	| temp5 |
	temp5 _ self
		customerWithIdentificationType: arg1
		number: arg2.
	self
		assert: arg3
		equals: temp5 firstName.
	self
		assert: arg4
		equals: temp5 lastName.
	self
		assert: arg1
		equals: temp5 identificationType.
	self
		assert: arg2
		equals: temp5 identificationNumber.
	^ temp5.! !

!ImportTest methodsFor: 'assertions'!
assertImportedRightNumberOfCustomers
	^ self
		assert: 2
		equals: (session selectAllOfType: Customer) size.! !

!ImportTest methodsFor: 'assertions'!
assertJuanPerezWasImportedCorrectly
	| temp1 |
	temp1 _ self
		assertCustomerWithIdentificationType: 'C'
		number: '23-25666777-9'
		hasFirstName: 'Juan'
		lastName: 'Perez'.
	self
		assertAddressOf: temp1
		at: 'Alem'
		hasNumber: 1122
		town: 'CABA'
		zipCode: 1001
		province: 'CABA'.! !

!ImportTest methodsFor: 'assertions'!
assertPepeSanchezWasImportedCorrecty
	| temp1 |
	temp1 _ self
		assertCustomerWithIdentificationType: 'D'
		number: '22333444'
		hasFirstName: 'Pepe'
		lastName: 'Sanchez'.
	self
		assertAddressOf: temp1
		at: 'San Martin'
		hasNumber: 3322
		town: 'Olivos'
		zipCode: 1636
		province: 'BsAs'.
	self
		assertAddressOf: temp1
		at: 'Maipu'
		hasNumber: 888
		town: 'Florida'
		zipCode: 1122
		province: 'Buenos Aires'.! !


!ImportTest methodsFor: 'setUp/tearDown'!
setUp
	session _ DataBaseSession for:
		(Array
			with: Address
			with: Customer).
	session beginTransaction.! !

!ImportTest methodsFor: 'setUp/tearDown'!
tearDown
	session close.! !


!ImportTest methodsFor: 'customer'!
customerWithIdentificationType: arg1 number: arg2
	^ (session
		select: [ :argm0_3 |
			argm0_3 identificationType = arg1 and: [ argm0_3 identificationNumber = arg2 ]]
		ofType: Customer) anyOne.! !


!ImportTest methodsFor: 'test data'!
addressFirstData
	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data'!
addressMisingFieldOfData
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data'!
addressWithAnAdditionalField
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,2344
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data'!
customerMissingOneFieldOfData
	^ ReadStream on: 'C,Pepe,Sanchez,D
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data'!
customerWithAnAdditionalField
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444,23544
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data'!
emptyImportData
	^ ReadStream on: ''.! !

!ImportTest methodsFor: 'test data'!
validImportData
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province'!
province
	^ province.! !

!Address methodsFor: 'province'!
province: arg1
	province _ arg1.! !


!Address methodsFor: 'street'!
isAt: arg1
	^ streetName = arg1.! !

!Address methodsFor: 'street'!
streetName
	^ streetName.! !

!Address methodsFor: 'street'!
streetName: arg1
	streetName _ arg1.! !

!Address methodsFor: 'street'!
streetNumber
	^ streetNumber.! !

!Address methodsFor: 'street'!
streetNumber: arg1
	streetNumber _ arg1.! !


!Address methodsFor: 'twon'!
town
	^ town.! !

!Address methodsFor: 'twon'!
town: arg1
	town _ arg1.! !


!Address methodsFor: 'zip code'!
zipCode
	^ zipCode.! !

!Address methodsFor: 'zip code'!
zipCode: arg1
	zipCode _ arg1.! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses'!
addAddress: arg1
	addresses add: arg1.! !

!Customer methodsFor: 'addresses'!
addressAt: arg1 ifNone: arg2
	^ addresses
		detect: [ :argm0_3 |
			argm0_3 isAt: arg1 ]
		ifNone: arg2.! !

!Customer methodsFor: 'addresses'!
addresses
	^ addresses.! !


!Customer methodsFor: 'name'!
firstName
	^ firstName.! !

!Customer methodsFor: 'name'!
firstName: arg1
	firstName _ arg1.! !

!Customer methodsFor: 'name'!
lastName
	^ lastName.! !

!Customer methodsFor: 'name'!
lastName: arg1
	lastName _ arg1.! !


!Customer methodsFor: 'identification'!
identificationNumber
	^ identificationNumber.! !

!Customer methodsFor: 'identification'!
identificationNumber: arg1
	identificationNumber _ arg1.! !

!Customer methodsFor: 'identification'!
identificationType
	^ identificationType.! !

!Customer methodsFor: 'identification'!
identificationType: arg1
	identificationType _ arg1.! !


!Customer methodsFor: 'initialization'!
initialize
	super initialize.
	addresses _ OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream lineData currentCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization'!
initializeFrom: arg1 into: arg2
	session _ arg2.
	readStream _ arg1.! !


!CustomerImporter methodsFor: 'assertions'!
assertAddressHasAllData
	^ lineData size < 6 ifTrue: [ self addressMissingFieldError ].! !

!CustomerImporter methodsFor: 'assertions'!
assertCustomerHasAllData
	^ lineData size < 5 ifTrue: [ self customerMissingFieldError ].! !

!CustomerImporter methodsFor: 'assertions'!
assertCustomerHasNoAdditionalFields
	^ lineData size > 5 ifTrue: [ self customerAdditionalFieldError ].! !

!CustomerImporter methodsFor: 'assertions'!
assertFirstLineIsCustomerPersonalDataAndImportIt
	self readLine.
	lineData first = 'C' ifFalse: [ self firstLineIsNotCustomerPersonalDataError ].
	self importCustomerPersonalData.! !

!CustomerImporter methodsFor: 'assertions'!
assertSourceIsNotEmpty
	^ self thereIsDataToImport ifFalse: [ self sourceIsEmptyError ].! !


!CustomerImporter methodsFor: 'error messages'!
addressMissingFieldError
	^ self error: self class addressMissingFieldErrorDescription.! !

!CustomerImporter methodsFor: 'error messages'!
customerAdditionalFieldError
	^ self error: self class customerWithAnAdditionalFieldErrorDescription.! !

!CustomerImporter methodsFor: 'error messages'!
customerMissingFieldError
	^ self error: self class customerMissingFieldErrorDescription.! !

!CustomerImporter methodsFor: 'error messages'!
firstLineIsNotCustomerPersonalDataError
	^ self error: self class dataDoesNotStartWithCustomerPersonalData.! !

!CustomerImporter methodsFor: 'error messages'!
sourceIsEmptyError
	^ self error: self class dataSourceIsEmptyErrorMessageText.! !


!CustomerImporter methodsFor: 'importing'!
addressAdditionalFieldError
	^ self error: self class addressWithAnAdditionalFieldError.! !

!CustomerImporter methodsFor: 'importing'!
assertAddressHasNoAdditionalField
	^ lineData size > 6 ifTrue: [ self addressAdditionalFieldError ].! !

!CustomerImporter methodsFor: 'importing'!
importAddress
	| temp1 |
	self assertAddressHasAllData.
	self assertAddressHasNoAdditionalField.
	temp1 _ Address new.
	currentCustomer addAddress: temp1.
	temp1 streetName: lineData second.
	temp1 streetNumber: lineData third asNumber.
	temp1 town: lineData fourth.
	temp1 zipCode: lineData fifth asNumber.
	temp1 province: lineData sixth.! !

!CustomerImporter methodsFor: 'importing'!
importCustomerPersonalData
	self assertCustomerHasAllData.
	self assertCustomerHasNoAdditionalFields.
	currentCustomer _ Customer new.
	currentCustomer firstName: lineData second.
	currentCustomer lastName: lineData third.
	currentCustomer identificationType: lineData fourth.
	currentCustomer identificationNumber: lineData fifth.
	session persist: currentCustomer.! !

!CustomerImporter methodsFor: 'importing'!
importLine
	self lineIsClient ifTrue: [ self importCustomerPersonalData ].
	self lineIsAddress ifTrue: [ self importAddress ].! !

!CustomerImporter methodsFor: 'importing'!
readLine
	| temp1 |
	temp1 _ readStream nextLine.
	lineData _ temp1 findTokens: $,.! !


!CustomerImporter methodsFor: 'evaluating'!
lineIsAddress
	^ lineData first = 'A'.! !

!CustomerImporter methodsFor: 'evaluating'!
lineIsClient
	^ lineData first = 'C'.! !

!CustomerImporter methodsFor: 'evaluating'!
thereIsDataToImport
	^ readStream atEnd not.! !

!CustomerImporter methodsFor: 'evaluating'!
value
	self assertSourceIsNotEmpty.
	self assertFirstLineIsCustomerPersonalDataAndImportIt.
	[ self thereIsDataToImport ] whileTrue: [
		self readLine.
		self importLine ].
	session commit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation'!
from: arg1 into: arg2
	^ self new
		initializeFrom: arg1
		into: arg2.! !


!CustomerImporter class methodsFor: 'importing'!
valueFrom: arg1 into: arg2
	^ (self
		from: arg1
		into: arg2) value.! !


!CustomerImporter class methodsFor: 'error messages'!
addressMissingFieldErrorDescription
	^ 'Address is missing a field'.! !

!CustomerImporter class methodsFor: 'error messages'!
addressWithAnAdditionalFieldError
	^ 'Address has an additional field'.! !

!CustomerImporter class methodsFor: 'error messages'!
customerMissingFieldErrorDescription
	^ 'Customer is missing a field'.! !

!CustomerImporter class methodsFor: 'error messages'!
customerWithAnAdditionalFieldErrorDescription
	^ 'Customer has an additional field'.! !

!CustomerImporter class methodsFor: 'error messages'!
dataDoesNotStartWithCustomerPersonalData
	^ 'Data source does not starts with customer personal data'.! !

!CustomerImporter class methodsFor: 'error messages'!
dataSourceIsEmptyErrorMessageText
	^ 'Data source is empty'.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management'!
beginTransaction
	^ self.! !

!DataBaseSession methodsFor: 'transaction management'!
commit
	(tables
		at: Customer
		ifAbsent: [ #() ]) do: [ :argm0_1 |
		self persistAddressesOf: argm0_1 ].! !


!DataBaseSession methodsFor: 'closing'!
close
	^ self.! !


!DataBaseSession methodsFor: 'persistence - private'!
defineIdOf: arg1
	arg1
		instVarNamed: 'id'
		put: (self newIdFor: arg1).! !

!DataBaseSession methodsFor: 'persistence - private'!
delay
	(Delay forMilliseconds: 100) wait.! !

!DataBaseSession methodsFor: 'persistence - private'!
objectsOfType: arg1
	^ tables
		at: arg1
		ifAbsent: [ #() ].! !

!DataBaseSession methodsFor: 'persistence - private'!
persistAddressesOf: arg1
	arg1 addresses do: [ :argm0_2 |
		self persist: argm0_2 ].! !


!DataBaseSession methodsFor: 'initialization'!
initializeFor: arg1
	configuration _ arg1.
	tables _ Dictionary new.
	id _ 0.! !


!DataBaseSession methodsFor: 'id'!
newIdFor: arg1
	id _ id + 1.
	^ id.! !


!DataBaseSession methodsFor: 'persistance'!
persist: arg1
	| temp2 |
	self delay.
	temp2 _ tables
		at: arg1 class
		ifAbsentPut: [ Set new ].
	self defineIdOf: arg1.
	temp2 add: arg1.
	(arg1 isKindOf: Customer) ifTrue: [ self persistAddressesOf: arg1 ].! !


!DataBaseSession methodsFor: 'selecting'!
select: arg1 ofType: arg2
	self delay.
	^ (self objectsOfType: arg2) select: arg1.! !

!DataBaseSession methodsFor: 'selecting'!
selectAllOfType: arg1
	self delay.
	^ (self objectsOfType: arg1) copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation'!
for: arg1
	^ self new initializeFor: arg1.! !
