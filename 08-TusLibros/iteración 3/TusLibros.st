!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 16:13:59'!
test01CantCreateCartForInvalidUser

	| restInterface invalidUser validPassword |
	
	restInterface _ self defaultRestInterface.
	invalidUser _ self invalidUser.
	validPassword _ self validPassword.
	
	self should: [ restInterface createCartFor: invalidUser with: validPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [:anError |
			self assert: RestInterface invalidUserErrorMessage equals: anError messageText.
			self assert: restInterface hasCarts not]. 
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 16:14:06'!
test02CantCreateCartForInvalidPassword

	| restInterface validUser invalidPassword |
	
	restInterface _ self defaultRestInterface.
	validUser _ self validUser.
	invalidPassword _ self invalidPassword.
	
	self should: [ restInterface createCartFor: validUser with: invalidPassword]
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [:anError |
			self assert: RestInterface invalidPasswordErrorMessageText equals: anError messageText.
			self assert: restInterface hasCarts not]. 
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 16:14:49'!
test03CreateCartCreatesANewCart

	| restInterface validUser validPassword |
	
	restInterface _ self defaultRestInterface.
	validUser _ self validUser.
	validPassword _ self validPassword.
	
	restInterface createCartFor: validUser with: validPassword.
	
	self assert: restInterface hasCarts 
	
		
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 16:29:43'!
test04CantListInvalidCart

	| restInterface |
	
	restInterface _ self defaultRestInterface.
	
	self should: [restInterface listCart: 85546] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError
			| self assert: RestInterface cartIdIsNotValidErrorMessage equals: anError messageText]
		
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 16:32:38'!
test05NewCartIsEmpty

	 | restInterface validUser validPassword cartId |
	
	restInterface _ self defaultRestInterface.
	validUser _ self validUser.
	validPassword _ self validPassword.
	
	cartId _ restInterface createCartFor: validUser with: validPassword.
	
	self assert: (restInterface listCart: cartId) isEmpty 
		
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 17:02:45'!
test06CantAddItemsToInvalidCart

	 | restInterface |
	
	restInterface _ self defaultRestInterface.
	
	self should: [restInterface add: 3 of: 'Harry potter' to: 5446] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError
			| self assert: RestInterface cartIdIsNotValidErrorMessage equals: anError messageText]
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 17:09:17'!
test07AddToCartAddItemsToCart

	 | restInterface validUser validPassword cartId book |
	
	restInterface _ self defaultRestInterface.
	validUser _ self validUser.
	validPassword _ self validPassword.
	book _ self bookSellByTheStore.
	
	cartId _ restInterface createCartFor: validUser with: validPassword.
	restInterface add: 3 of: book to: cartId.
	
	self assert: 3 equals: ((restInterface listCart: cartId) occurrencesOf: book).
	
		
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 18:03:31'!
test10CanNotCheckOutInvalidCart

	 | restInterface  |
	
	restInterface _ self defaultRestInterface.
	
	self should: [ restInterface checkout: 7845 
				withCreditCard: '1234567812345678'
				expiredOn: self monthNotExpired 
				ownedBy: 'Jorge Drexler' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError
			| self assert: RestInterface cartIdIsNotValidErrorMessage equals: anError messageText]
	
		
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'mf 6/13/2022 18:01:14'!
test11CanCheckoutCart

	 | restInterface validUser validPassword cartId book bookPrice |
	
	restInterface _ self defaultRestInterface.
	validUser _ self validUser.
	validPassword _ self validPassword.
	book _ self bookSellByTheStore.
	bookPrice _ self bookPrice.
	
	cartId _ restInterface createCartFor: validUser with: validPassword.
	restInterface add: 3 of: book to: cartId.
	
	restInterface checkout: cartId 
				withCreditCard: '1234567812345678'
				expiredOn: self monthNotExpired
				ownedBy: 'Jorge Drexler'.
				
	self assert: bookPrice * 3 equals: restInterface salesBook first total
	! !


!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 17:35:18'!
bookPrice

	^StoreTestObjectsFactory new itemSellByTheStorePrice ! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 17:09:54'!
bookSellByTheStore
	
	^StoreTestObjectsFactory new itemSellByTheStore ! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 17:14:11'!
creditCard
	
	^StoreTestObjectsFactory new notExpiredCreditCard ! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 17:50:48'!
debit: anAmmount from: aCreditCard
	
	! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 17:51:06'!
defaultRestInterface

	| usersAndPasswords catalog |
	
	usersAndPasswords _ Dictionary new.
	usersAndPasswords 
		at: self validUser 
		put: self validPassword.
		
	catalog _ self storeTestObjectsFactory defaultCatalog.
	
	^RestInterface withUsersAndPaswords: usersAndPasswords withCatalog: catalog withMerchantProcessor: self.! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 16:03:10'!
invalidPassword
	
	^'invalidPassword'! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 15:42:41'!
invalidUser
	
	^'invalidUser'! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 18:02:57'!
monthNotExpired
	
	| now |
	now _ DateAndTime now.
	
	^Month month: now monthIndex year: now yearNumber + 1! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 16:43:34'!
storeTestObjectsFactory

	^ StoreTestObjectsFactory new! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 15:43:01'!
validPassword
	
	^'validPassword'! !

!RestInterfaceTest methodsFor: 'set up' stamp: 'mf 6/13/2022 15:51:52'!
validUser
	
	^'validUser'! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'mf 6/13/2022 16:55:34'!
contents
	
	| contents |
	
	contents _ Bag new.
	contents addAll: items.
	^contents  ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'usersAndPasswords carts nextCartId catalog dictionaryOfUsersAndPasswords salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'carts' stamp: 'mf 6/13/2022 17:05:25'!
add: aQuantity of: anItem to: aCartId 
	
	| cart |
	cart _ self search: aCartId.
	cart add: aQuantity of: anItem ! !

!RestInterface methodsFor: 'carts' stamp: 'mf 6/13/2022 16:40:09'!
addNewCart
	
	| newCart cartId |
	
	newCart _ Cart acceptingItemsOf: catalog. 
	cartId _ self newCartId.
	carts at: cartId put: newCart.
	
	^cartId! !

!RestInterface methodsFor: 'carts' stamp: 'mf 6/13/2022 16:17:58'!
createCartFor: aUser with: aPassword 
	
	| cartId |
	
	self assert: aUser isAuthenticatedWith: aPassword.
	cartId _ self addNewCart.
	
	^cartId! !

!RestInterface methodsFor: 'carts' stamp: 'mf 6/13/2022 17:04:14'!
listCart: aCartId 
	
	| cart |
	
	cart _ self search: aCartId.
	
	^cart contents! !

!RestInterface methodsFor: 'carts' stamp: 'mf 6/13/2022 16:20:46'!
newCartId
	
	| newCartId |
	
	newCartId _ nextCartId.
	nextCartId _ nextCartId + 1.
	
	^newCartId! !

!RestInterface methodsFor: 'carts' stamp: 'mf 6/13/2022 17:04:14'!
search: aCartId

	^ carts at: aCartId ifAbsent: [self error: 	RestInterface cartIdIsNotValidErrorMessage]! !


!RestInterface methodsFor: 'testing' stamp: 'mf 6/13/2022 16:15:56'!
hasCarts

	^carts isEmpty not! !

!RestInterface methodsFor: 'testing' stamp: 'mf 6/13/2022 17:32:35'!
salesBook

	^salesBook copy.! !


!RestInterface methodsFor: 'initialization' stamp: 'mf 6/13/2022 17:46:28'!
initializeWithUsersAndPaswords: aDictionaryOfUsersAndPasswords withCatalog: aCatalog withMerchantProcesor: aMerchantProcessor  
	
	usersAndPasswords _ aDictionaryOfUsersAndPasswords.
	carts _ Dictionary new.
	nextCartId _ 1.
	catalog _ aCatalog.
	salesBook _ OrderedCollection new.
	merchantProcessor _ aMerchantProcessor.! !


!RestInterface methodsFor: 'assertions' stamp: 'mf 6/13/2022 15:58:51'!
assert: aUser isAuthenticatedWith: aPassword 
	
	| userPassword |
	
	userPassword _ usersAndPasswords at: aUser ifAbsent: [self error: RestInterface invalidUserErrorMessage].
	userPassword = aPassword ifFalse: [self error: RestInterface invalidPasswordErrorMessageText]
	! !


!RestInterface methodsFor: 'checkout' stamp: 'mf 6/13/2022 18:08:47'!
checkout: aCartId withCreditCard: aCreditCardNumber expiredOn: aMonth ownedBy: aNameOfAClient
	
	| cart creditCard |
	
	cart _ self search: aCartId.
	creditCard _ CreditCard expiringOn: aMonth.
	
	(Cashier
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: DateAndTime now 
		registeringOn: salesBook) checkOut
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'error messages' stamp: 'mf 6/13/2022 16:29:19'!
cartIdIsNotValidErrorMessage
	
	^'Cart id does not belong to any cart'! !

!RestInterface class methodsFor: 'error messages' stamp: 'mf 6/13/2022 15:49:28'!
invalidPasswordErrorMessageText
	
	^'Wrong password'! !

!RestInterface class methodsFor: 'error messages' stamp: 'mf 6/13/2022 15:44:25'!
invalidUserErrorMessage
	
	^'User is not valid'! !


!RestInterface class methodsFor: 'instance creation' stamp: 'mf 6/13/2022 18:09:28'!
withUsersAndPaswords: aDictionaryOfUsersAndPasswords withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor 
	
	^self new initializeWithUsersAndPaswords: aDictionaryOfUsersAndPasswords withCatalog: aCatalog withMerchantProcesor: aMerchantProcessor ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
