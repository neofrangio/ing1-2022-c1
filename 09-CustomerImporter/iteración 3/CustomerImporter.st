!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'FM 6/29/2022 23:31:28'!
test01Import

	CustomerImporter valueFrom: self validImportData into: system.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'FM 6/29/2022 23:33:36'!
test02ImportEmptyDataRaiseError

	self should: 
		[CustomerImporter valueFrom: self emptyImportData into: system.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: CustomerImporter dataSourceIsEmptyErrorMessageText equals: anError messageText.
			self assert: system customers isEmpty] ! !

!ImportTest methodsFor: 'tests' stamp: 'FM 6/29/2022 23:33:43'!
test03sourceMustStartWithClient

	self should: 
		[CustomerImporter valueFrom: self addressFirstData into: system.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert:  CustomerImporter dataDoesNotStartWithCustomerPersonalData equals: anError messageText.
			self assert: system customers isEmpty] ! !

!ImportTest methodsFor: 'tests' stamp: 'FM 6/29/2022 23:31:21'!
test04customerDataMustBeComplete

	self should: 
		[CustomerImporter valueFrom: self customerMissingOneFieldOfData into: system.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: CustomerImporter customerMissingFieldErrorDescription equals: anError messageText.] ! !

!ImportTest methodsFor: 'tests' stamp: 'FM 6/29/2022 23:31:17'!
test05addressDataMustBeComplete

	self should: 
		[CustomerImporter valueFrom: self addressMisingFieldOfData into: system.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: CustomerImporter addressMissingFieldErrorDescription equals: anError messageText.] ! !

!ImportTest methodsFor: 'tests' stamp: 'FM 6/29/2022 23:31:15'!
test06customerHasDataOverflow

	self should: 
		[CustomerImporter valueFrom: self customerWithAnAdditionalField into: system.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: CustomerImporter customerWithAnAdditionalFieldErrorDescription equals: anError messageText.] ! !

!ImportTest methodsFor: 'tests' stamp: 'FM 6/29/2022 23:31:09'!
test07addressHasDataOverflow

	self should: 
		[CustomerImporter valueFrom: self addressWithAnAdditionalField into: system.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: CustomerImporter addressWithAnAdditionalFieldError equals: anError messageText.] ! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'FM 6/30/2022 00:05:55'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'FM 6/29/2022 23:33:17'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system customers size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'FM 6/30/2022 00:05:14'!
setUp

	self setSystem.
	system start.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'FM 6/29/2022 23:20:30'!
tearDown

	system stop.
	! !


!ImportTest methodsFor: 'test data' stamp: 'mf 6/26/2022 20:24:37'!
addressFirstData

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'mf 6/26/2022 20:43:47'!
addressMisingFieldOfData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'FM 6/26/2022 21:55:49'!
addressWithAnAdditionalField

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,2344
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'FM 6/26/2022 21:33:44'!
customerMissingOneFieldOfData

	^ ReadStream on:
'C,Pepe,Sanchez,D
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'FM 6/26/2022 21:36:07'!
customerWithAnAdditionalField
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444,23544
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'mf 6/26/2022 20:08:28'!
emptyImportData

	^ ReadStream on: ''! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'configuration' stamp: 'FM 6/30/2022 00:10:57'!
defineSystemType: aSystemType
	Smalltalk at: #ImportTestProtocol put: aSystemType! !

!ImportTest methodsFor: 'configuration' stamp: 'FM 6/30/2022 00:18:47'!
setSystem

	(self systemTypeDefinedOnEnviroment) = #Dev ifTrue: [^system _ TransientCustomerSystem new.].
	(self systemTypeDefinedOnEnviroment) = #Prod ifTrue: [^system _ PersistentCustomerSystem new.].
	
	"El entorno por default es el entorno de desarrollo"
	system _ TransientCustomerSystem new.! !

!ImportTest methodsFor: 'configuration' stamp: 'FM 6/30/2022 00:17:00'!
systemTypeDefinedOnEnviroment
	^(Smalltalk associationOrUndeclaredAt: #ImportTestProtocol) value! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'readStream lineData currentCustomer system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'FM 6/29/2022 23:29:11'!
initializeFrom: aReadStream into: aSystem
	system := aSystem.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'assertions' stamp: 'FM 6/26/2022 21:53:21'!
assertAddressHasAllData

	^ (lineData size < 6) ifTrue: [self addressMissingFieldError ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'mf 6/26/2022 20:55:03'!
assertCustomerHasAllData

	^ (lineData size < 5) ifTrue: [self customerMissingFieldError]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'FM 6/26/2022 21:48:40'!
assertCustomerHasNoAdditionalFields

	^ (lineData size > 5) ifTrue: [self customerAdditionalFieldError ]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'mf 6/26/2022 20:38:40'!
assertFirstLineIsCustomerPersonalDataAndImportIt

	self readLine.
	(lineData first = 'C') ifFalse: [self firstLineIsNotCustomerPersonalDataError ].
	self importCustomerPersonalData! !

!CustomerImporter methodsFor: 'assertions' stamp: 'mf 6/26/2022 20:22:19'!
assertSourceIsNotEmpty

	^ self thereIsDataToImport ifFalse: [self sourceIsEmptyError ]! !


!CustomerImporter methodsFor: 'error messages' stamp: 'FM 6/26/2022 21:52:51'!
addressMissingFieldError

	^ self error: self class addressMissingFieldErrorDescription! !

!CustomerImporter methodsFor: 'error messages' stamp: 'FM 6/26/2022 21:47:43'!
customerAdditionalFieldError

	^ self error: self class customerWithAnAdditionalFieldErrorDescription! !

!CustomerImporter methodsFor: 'error messages' stamp: 'mf 6/26/2022 20:54:29'!
customerMissingFieldError

	^ self error: self class customerMissingFieldErrorDescription! !

!CustomerImporter methodsFor: 'error messages' stamp: 'mf 6/26/2022 20:36:58'!
firstLineIsNotCustomerPersonalDataError

	^ self error: self class dataDoesNotStartWithCustomerPersonalData! !

!CustomerImporter methodsFor: 'error messages' stamp: 'mf 6/26/2022 20:20:08'!
sourceIsEmptyError

	^ self error: self class dataSourceIsEmptyErrorMessageText! !


!CustomerImporter methodsFor: 'importing' stamp: 'FM 6/26/2022 21:58:08'!
addressAdditionalFieldError

	^ self error: self class addressWithAnAdditionalFieldError! !

!CustomerImporter methodsFor: 'importing' stamp: 'FM 6/26/2022 21:58:47'!
assertAddressHasNoAdditionalField

	^ (lineData size > 6) ifTrue: [self addressAdditionalFieldError ]! !

!CustomerImporter methodsFor: 'importing' stamp: 'FM 6/26/2022 21:58:47'!
importAddress

	| newAddress |
	
	self assertAddressHasAllData.
	
	self assertAddressHasNoAdditionalField.
	
	newAddress := Address new.
	currentCustomer addAddress: newAddress.
	newAddress streetName: lineData second.
	newAddress streetNumber: lineData third asNumber .
	newAddress town: lineData fourth.
	newAddress zipCode: lineData fifth asNumber .
	newAddress province: lineData sixth! !

!CustomerImporter methodsFor: 'importing' stamp: 'FM 6/29/2022 23:29:37'!
importCustomerPersonalData

	self assertCustomerHasAllData.
	
	self assertCustomerHasNoAdditionalFields.
	
	currentCustomer := Customer new.
	currentCustomer firstName: lineData second.
	currentCustomer lastName: lineData third.
	currentCustomer identificationType: lineData fourth.
	currentCustomer identificationNumber: lineData fifth.
	system import: currentCustomer! !

!CustomerImporter methodsFor: 'importing' stamp: 'mf 6/26/2022 20:00:58'!
importLine

	(self lineIsClient) ifTrue: [ 
			self importCustomerPersonalData. 
			].

		(self lineIsAddress) ifTrue: [ 
			self importAddress
			]! !

!CustomerImporter methodsFor: 'importing' stamp: 'mf 6/26/2022 19:54:39'!
readLine

	| line |
		line := readStream nextLine.
		lineData _ line findTokens: $,! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'mf 6/26/2022 20:00:40'!
lineIsAddress

	^ lineData first =  'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'mf 6/26/2022 20:00:23'!
lineIsClient

	^ lineData first =  'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'mf 6/26/2022 19:58:32'!
thereIsDataToImport

	^ readStream atEnd not! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'FM 6/29/2022 23:29:23'!
value
	
	self assertSourceIsNotEmpty.
	
	self assertFirstLineIsCustomerPersonalDataAndImportIt.
	
	[ self thereIsDataToImport ] whileTrue: [ 
		self readLine.
		self importLine.
		].
	
	system commit.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'mf 6/26/2022 20:56:35'!
addressMissingFieldErrorDescription
	
	^'Address is missing a field'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'FM 6/26/2022 21:56:44'!
addressWithAnAdditionalFieldError
	
	^'Address has an additional field'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'mf 6/26/2022 20:47:09'!
customerMissingFieldErrorDescription
	
	^'Customer is missing a field'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'FM 6/26/2022 21:44:10'!
customerWithAnAdditionalFieldErrorDescription	
	^'Customer has an additional field'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'mf 6/26/2022 20:37:07'!
dataDoesNotStartWithCustomerPersonalData
	
	^'Data source does not starts with customer personal data'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'mf 6/26/2022 20:19:28'!
dataSourceIsEmptyErrorMessageText
	
	^'Data source is empty'
	! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'accessing' stamp: 'FM 6/29/2022 23:34:50'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'accessing' stamp: 'FM 6/29/2022 23:33:03'!
customers
	^session selectAllOfType: Customer! !


!PersistentCustomerSystem methodsFor: 'saving' stamp: 'FM 6/29/2022 23:30:34'!
commit
	session commit.! !

!PersistentCustomerSystem methodsFor: 'saving' stamp: 'FM 6/29/2022 23:30:17'!
import: aCustomer
	session persist: aCustomer! !


!PersistentCustomerSystem methodsFor: 'start/stop' stamp: 'FM 6/29/2022 23:38:25'!
start
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.! !

!PersistentCustomerSystem methodsFor: 'start/stop' stamp: 'FM 6/29/2022 23:20:55'!
stop
	session close.! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'saving' stamp: 'FM 6/29/2022 23:42:08'!
commit! !

!TransientCustomerSystem methodsFor: 'saving' stamp: 'FM 6/29/2022 23:40:12'!
import: aCustomer
	customers add: aCustomer! !


!TransientCustomerSystem methodsFor: 'accessing' stamp: 'FM 6/29/2022 23:41:55'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]].! !

!TransientCustomerSystem methodsFor: 'accessing' stamp: 'FM 6/29/2022 23:40:29'!
customers
	^customers.! !


!TransientCustomerSystem methodsFor: 'start/stop' stamp: 'FM 6/29/2022 23:39:39'!
start
	customers _ OrderedCollection new.! !

!TransientCustomerSystem methodsFor: 'start/stop' stamp: 'FM 6/29/2022 23:39:57'!
stop
	customers _ nil.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
