!classDefinition: #CheckoutTest category: 'TusLibros.com'!
TestCase subclass: #CheckoutTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CheckoutTest methodsFor: 'set up' stamp: 'mf 6/8/2022 18:20:32'!
cartWithEmptyPriceList

	^ Cart fromPriceList: PriceList new! !

!CheckoutTest methodsFor: 'set up' stamp: 'mf 6/8/2022 18:21:43'!
cartWithTwoProductsInPriceList

	| priceList |
	priceList _ PriceList new.
	priceList add: 'Harry potter' withPrice: 30.
	priceList add: '50 shades of grey' withPrice: 1. 
	^Cart fromPriceList: priceList! !

!CheckoutTest methodsFor: 'set up' stamp: 'mf 6/8/2022 18:23:17'!
creditCard
	
	^CreditCard withNumber: '1234567812345678' 
		clientName: 'Stephen King' 
		andExpirationDate: (GregorianMonthOfYear year: 2012 month: April)! !

!CheckoutTest methodsFor: 'set up' stamp: 'FM 6/9/2022 08:53:14'!
decliningMerchantProcessor

	^ DecliningMerchantProcessor new! !

!CheckoutTest methodsFor: 'set up' stamp: 'mf 6/8/2022 18:51:37'!
expiredCreditCardDate
	
	^FixedGregorianDate year: 2012 month: May dayNumber: 1! !

!CheckoutTest methodsFor: 'set up' stamp: 'mf 6/8/2022 18:22:08'!
firstProductInPriceList

	^'Harry potter'! !

!CheckoutTest methodsFor: 'set up' stamp: 'mf 6/8/2022 18:22:22'!
firstProductPrice
	
	^30! !

!CheckoutTest methodsFor: 'set up' stamp: 'FM 6/9/2022 08:40:09'!
workingCreditCardDate
	^FixedGregorianDate year: 2012 month: April dayNumber: 30.! !

!CheckoutTest methodsFor: 'set up' stamp: 'FM 6/9/2022 09:02:17'!
workingMerchantProcessor
	^ WorkingMerchantProcessor new.! !


!classDefinition: #CartTest category: 'TusLibros.com'!
CheckoutTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CartTest methodsFor: 'tests' stamp: 'mf 6/7/2022 20:20:52'!
test01cantAddProductThatsNotInPriceList
	
	| cart |
	cart _ self cartWithEmptyPriceList.
	
	self should: [cart add: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: Cart productNotInPriceList.
			self assert: cart isEmpty.
			]
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/8/2022 03:35:14'!
test02CartIncludesAddedProduct
	
	| cart product |
	cart _ self cartWithTwoProductsInPriceList.
	product _  self firstProductInPriceList.
	
	cart add: product.
	
	self assert: (cart includes: product).! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/8/2022 03:36:13'!
test03CartWithProductsIsNotEmpty
	
	| cart product |
	cart _ self cartWithTwoProductsInPriceList.
	product _ self firstProductInPriceList.
	
	cart add: product.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/7/2022 20:17:09'!
test04QuantityOfProductNotInCartIsCero
	
	| cart |
	cart _ self cartWithEmptyPriceList.
	
	self assert: 0 equals: (cart quantityOf: 1).
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/8/2022 03:37:39'!
test05QuantityOfProductAddedOnceIsOne
	
	| cart product |
	cart _ self cartWithTwoProductsInPriceList.
	product _ self firstProductInPriceList.
	
	cart add: product.
	
	self assert: 1 equals: (cart quantityOf: product).
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/8/2022 03:39:06'!
test06QuantityOfProductAddedTwiceIsTwo
	
	| cart product |
	cart _ self cartWithTwoProductsInPriceList.
	product _ self firstProductInPriceList.
	
	cart add: product.
	cart add: product.
	
	self assert: 2 equals: (cart quantityOf: product).
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/8/2022 03:39:43'!
test07AddingMultipleCopiesOfProduct
	
	| cart product |
	cart _ self cartWithTwoProductsInPriceList.
	product _ self firstProductInPriceList.
	
	cart add: 2 of: product.
	
	self assert: 2 equals: (cart quantityOf: product).
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/8/2022 03:40:16'!
test08CantAddNegativeQuantityOfProduct
	
	| cart product |
	cart _ self cartWithTwoProductsInPriceList.
	product _ self firstProductInPriceList.

	self should: [cart add: -1 of: product]
		raise: Error
		withExceptionDo: [:anError |
			self assert: Cart quantityAddedShouldBePostivie equals: anError messageText.
			self assert: cart isEmpty.
			]
	! !

!CartTest methodsFor: 'tests' stamp: 'mf 6/8/2022 03:40:46'!
test09CantAddNotIntegerQuantityOfProduct
	
	| cart product |
	cart _ self cartWithTwoProductsInPriceList.
	product _ self firstProductInPriceList.

	self should: [cart add: 0.2 of: product]
		raise: Error
		withExceptionDo: [:anError |
			self assert: Cart quantityShouldBeAnInteger equals: anError messageText.
			self assert: cart isEmpty.
			]
	! !

!CartTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:32:34'!
test10EmptyCartHasTotalPriceEqualToZero

	| cart |
	
	cart _ self cartWithTwoProductsInPriceList .
	
	self assert: 0 equals: cart totalPrice.
	
	
	! !

!CartTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:33:00'!
test11CartWithOneProductHasTotalPriceEqualToProductPrice

	| cart product |
	
	cart _ self cartWithTwoProductsInPriceList .
	product _ self firstProductInPriceList.
	
	cart add: product.
	
	self assert: (self firstProductPrice) equals: cart totalPrice.
	
	
	! !


!classDefinition: #CashierTest category: 'TusLibros.com'!
CheckoutTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CashierTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:59:31'!
test01CantCheckoutCartWithNoProducts
	
	| cart cashier creditCard |
	cart _ CartTest new cartWithEmptyPriceList .
	cashier _ Cashier workingWith: ''.
	creditCard _ self creditCard.
	
	self should: [cashier checkout: cart paidWith: creditCard on: ''.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: Cashier cartHasNoProducts.
			self deny: (cashier hasRegistered: cart).
			]! !

!CashierTest methodsFor: 'tests' stamp: 'FM 6/9/2022 09:00:19'!
test02CantCheckoutCartWithInvalidPaymentMethod
	
	| cart cashier creditCard |
	cart _ self cartWithTwoProductsInPriceList .
	cart add: (self firstProductInPriceList).
	cashier _ Cashier workingWith: ''.
	creditCard _ 'ashqje'.
	
	self should: [cashier checkout: cart paidWith: creditCard on: ''.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: Cashier paymentMethodIsNotCreditCard.
			self deny: (cashier hasRegistered: cart)
			]! !

!CashierTest methodsFor: 'tests' stamp: 'FM 6/9/2022 09:00:26'!
test03CantCheckoutCartWithExpiredCreditCard
	
	| cart cashier creditCard date |
	cart _ self cartWithTwoProductsInPriceList .
	cart add: self firstProductInPriceList.
	cashier _ Cashier workingWith: ''.
	creditCard _ self creditCard.
	date _ self expiredCreditCardDate.
	
	self should: [cashier checkout: cart paidWith: creditCard on: date.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: Cashier creditCardHasExpired.
			self deny: (cashier hasRegistered: cart)
			]! !

!CashierTest methodsFor: 'tests' stamp: 'mf 6/9/2022 15:35:00'!
test04CartIsNotRegisteredIfMerchantProcessorDeclinesCard
	
	| cart cashier creditCard date merchantProcessor |
	cart _ self cartWithTwoProductsInPriceList .
	cart add: self firstProductInPriceList.
	merchantProcessor _ self decliningMerchantProcessor.
	cashier _ Cashier workingWith: merchantProcessor.
	creditCard _ self creditCard.
	date _ self workingCreditCardDate.
	
	self should: [cashier checkout: cart paidWith: creditCard on: date.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: Cashier cantDebitFromCreditCardErrorDescription.
			self deny: (cashier hasRegistered: cart)
			]! !

!CashierTest methodsFor: 'tests' stamp: 'FM 6/9/2022 09:01:08'!
test05CartIsRegisteredAfterCheckout
	
	| cart cashier creditCard date merchantProcessor |
	cart _ self cartWithTwoProductsInPriceList .
	cart add: self firstProductInPriceList.
	merchantProcessor _ self workingMerchantProcessor.
	cashier _ Cashier workingWith: merchantProcessor.
	creditCard _ self creditCard.
	date _ self workingCreditCardDate.
	
	cashier checkout: cart paidWith: creditCard on: date.
	
	self assert: (cashier hasRegistered: cart).! !

!CashierTest methodsFor: 'tests' stamp: 'mf 6/9/2022 15:39:07'!
test06DebitedAmmountIsTotalPriceOfCart
	
	| cart cashier creditCard date merchantProcessor debitedAmmount |
	cart _ self cartWithTwoProductsInPriceList .
	cart add: self firstProductInPriceList.
	merchantProcessor _ self workingMerchantProcessor.
	cashier _ Cashier workingWith: merchantProcessor.
	creditCard _ self creditCard.
	date _ self workingCreditCardDate.
	
	debitedAmmount _ cashier checkout: cart paidWith: creditCard on: date.
	
	self assert: cart totalPrice equals: debitedAmmount.! !


!classDefinition: #CreditCardTest category: 'TusLibros.com'!
CheckoutTest subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/7/2022 22:49:34'!
test01CreditCardNumberMustBe16Digits

	self should: [CreditCard withNumber: '123456' clientName: '' andExpirationDate: ''.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: CreditCard cardNumberDoesNotHave16Digits.
			]! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/7/2022 22:53:45'!
test02CreditCardNameMustNotBeEmpty

	self should: [CreditCard withNumber: '1234567812345678' clientName: '' andExpirationDate: ''.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: CreditCard cardNameIsEmpty.
			]! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:33:23'!
test03CreditCardNameMustNotStartWithSpace

	self should: [CreditCard withNumber: '1234567812345678' clientName: ' Pedro Picapiedras' andExpirationDate: ''.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: CreditCard cardNameStartsWithSpaceErrorDescription.
			]! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:33:38'!
test04CreditCardNameMustNotEndWithSpace

	self should: [CreditCard withNumber: '1234567812345678' clientName: 'Pedro Picapiedras ' andExpirationDate: ''.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: CreditCard cardNameEndsWithSpaceErrorDescription.
			]! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:34:02'!
test05CreditCardExpirationDateMustBeGregorianMonthOfYear

	self should: [CreditCard withNumber: '1234567812345678' clientName: 'Pedro Picapiedras' andExpirationDate: ''.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText  equals: 
				CreditCard cardExpirationDateMustBeAGregorianMonthOfYearErrorDescrption.
			]! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:34:51'!
test06CreditCardNumberIsSavedCorrectly

	| creditCard |
	
	creditCard _ self creditCard.
	
	self assert: '1234567812345678' equals: creditCard number.! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:35:05'!
test07CreditCardNameIsSavedCorrectly

	| creditCard |
	
	creditCard _ self creditCard.
	
	self assert: 'Stephen King' equals: creditCard clientName! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:35:16'!
test08CreditCardExpirationDateIsSavedCorrectly

	| creditCard |
	
	creditCard _ self creditCard.
	
	self assert: (GregorianMonthOfYear year: 2012 month: April) equals: creditCard expirationDate! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:35:45'!
test09CreditCardIsExpiredOnDateAfterExpirationDate

	| creditCard date |
	
	creditCard _ self creditCard.
	date _ FixedGregorianDate year: 2012 month: May dayNumber: 1.
	
	self assert: (creditCard isExpiredOn: date)! !

!CreditCardTest methodsFor: 'tests' stamp: 'FM 6/9/2022 08:36:02'!
test10CreditCardIsNotExpiredBeforeExpirationDate

	| creditCard date |
	
	creditCard _ self creditCard.
	date _ FixedGregorianDate year: 2012 month: April dayNumber: 30.
	
	self deny: (creditCard isExpiredOn: date)! !


!classDefinition: #PriceListTest category: 'TusLibros.com'!
CheckoutTest subclass: #PriceListTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!PriceListTest methodsFor: 'tests' stamp: 'mf 6/8/2022 03:29:07'!
test01priceMustBeNumber
	 
	| priceList product |
	priceList _ PriceList new.
	product _ 'Harry potter'.
	
	self should: [priceList add: product withPrice: 'sefsd']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: PriceList priceIsNotANumber.
			self assert: (priceList includes: product) not. ]! !

!PriceListTest methodsFor: 'tests' stamp: 'FM 6/7/2022 21:46:27'!
test02priceMustBeStrictlyPositive
	 
	| priceList product |
	priceList _ PriceList new.
	product _ 'Harry potter'.
	
	self should: [priceList add: product withPrice: -30 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: PriceList priceIsNotStrictlyPositive.
			self assert: (priceList includes: product) not. ]! !

!PriceListTest methodsFor: 'tests' stamp: 'FM 6/7/2022 21:51:42'!
test03priceListIncludesAddedProduct
	 
	| priceList product |
	priceList _ PriceList new.
	product _ 'Harry potter'.
	
	priceList add: product withPrice: 30.
	
	self assert: (priceList includes: product)! !

!PriceListTest methodsFor: 'tests' stamp: 'FM 6/7/2022 21:51:47'!
test04priceListKnowsProductPrice
	 
	| priceList product |
	priceList _ PriceList new.
	product _ 'Harry potter'.
	
	priceList add: product withPrice: 30.
	
	self assert: 30 equals: (priceList priceOf: product)! !


!classDefinition: #Cart category: 'TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'priceList products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cart methodsFor: 'adding' stamp: 'mf 6/7/2022 20:16:16'!
add: aProduct

	self add: 1 of: aProduct
	
	! !

!Cart methodsFor: 'adding' stamp: 'mf 6/7/2022 20:13:31'!
add: aQuantity of: aProduct 

	self assertAProductIsInPriceList: aProduct.
	self assertIsAValidQuantity: aQuantity.
	products add: aProduct withOccurrences: aQuantity.! !


!Cart methodsFor: 'initialization' stamp: 'mf 6/7/2022 20:18:48'!
initializeFromPriceList: aPriceList 
	
	priceList _ aPriceList.
	products _ Bag new! !


!Cart methodsFor: 'assertions' stamp: 'mf 6/7/2022 20:18:06'!
assertAProductIsInPriceList: aProduct
	
	(priceList includes: aProduct) ifFalse: [self error: Cart productNotInPriceList]! !

!Cart methodsFor: 'assertions' stamp: 'FM 6/5/2022 22:52:20'!
assertAQuantityIsAnInteger: aQuantity
	
	(aQuantity isInteger) ifFalse: [self error: Cart quantityShouldBeAnInteger].! !

!Cart methodsFor: 'assertions' stamp: 'FM 6/5/2022 22:52:03'!
assertAQuantityIsPositive: aQuantity
	
	(aQuantity > 0) ifFalse: [self error: Cart quantityAddedShouldBePostivie ].! !

!Cart methodsFor: 'assertions' stamp: 'mf 6/6/2022 03:33:17'!
assertIsAValidQuantity: aQuantity

	self assertAQuantityIsPositive: aQuantity.
	self assertAQuantityIsAnInteger: aQuantity! !


!Cart methodsFor: 'testing' stamp: 'mf 6/5/2022 18:30:59'!
includes: aProduct
	
	^products includes: aProduct! !

!Cart methodsFor: 'testing' stamp: 'mf 6/5/2022 18:33:55'!
isEmpty
	
	^products isEmpty! !

!Cart methodsFor: 'testing' stamp: 'mf 6/5/2022 18:45:39'!
quantityOf: aProduct 
	
	^products occurrencesOf: aProduct! !


!Cart methodsFor: 'checkout' stamp: 'mf 6/8/2022 18:17:17'!
totalPrice
	
	^products inject: 0 into: [:subTotal :aProduct | subTotal + (priceList priceOf: aProduct)]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'mf 6/7/2022 20:18:48'!
fromPriceList: aCatalogue
	
	^self new initializeFromPriceList: aCatalogue ! !


!Cart class methodsFor: 'error messages' stamp: 'mf 6/7/2022 20:18:13'!
productNotInPriceList
	
	^'Product is not in price list'! !

!Cart class methodsFor: 'error messages' stamp: 'FM 6/5/2022 22:43:31'!
quantityAddedShouldBePostivie
	
	^'Quantity of added product should be positive'! !

!Cart class methodsFor: 'error messages' stamp: 'FM 6/5/2022 22:47:19'!
quantityShouldBeAnInteger
	
	^'Quantity of added product should be an integer'! !


!classDefinition: #Cashier category: 'TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'registeredPurchases merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!Cashier methodsFor: 'checkout' stamp: 'mf 6/9/2022 15:39:35'!
checkout: aCart paidWith: aCreditCard on: aDate
	
	self assertCartHasProducts: aCart.
	self assertPaymentMethodIsCreditCard: aCreditCard.
	self assertACreditCard: aCreditCard isNotExpiredOn: aDate.
	
	[merchantProcessor debit: aCart totalPrice to: aCreditCard] ifError: [self error: 
		self class cantDebitFromCreditCardErrorDescription].
	
	self register: aCart.
	
	^aCart totalPrice 
	! !

!Cashier methodsFor: 'checkout' stamp: 'FM 6/9/2022 08:41:52'!
register: aCart 
	registeredPurchases add: aCart.! !


!Cashier methodsFor: 'assertions' stamp: 'mf 6/8/2022 18:55:05'!
assertACreditCard: aCreditCard isNotExpiredOn: aDate 
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: Cashier creditCardHasExpired]! !

!Cashier methodsFor: 'assertions' stamp: 'mf 6/8/2022 18:53:39'!
assertCartHasProducts: aCart 
	(aCart isEmpty) ifTrue: [self error: Cashier cartHasNoProducts]! !

!Cashier methodsFor: 'assertions' stamp: 'FM 6/7/2022 22:20:06'!
assertPaymentMethodIsCreditCard: aPaymentMethod 
	(aPaymentMethod class = CreditCard) ifFalse: [self error: Cashier paymentMethodIsNotCreditCard] .! !


!Cashier methodsFor: 'testing' stamp: 'FM 6/9/2022 08:42:57'!
hasRegistered: aCart 
	
	^registeredPurchases includes: aCart.! !


!Cashier methodsFor: 'initialization' stamp: 'FM 6/9/2022 08:52:18'!
initializeWorkingWith: aMerchantProcessor 

	registeredPurchases _ OrderedCollection new.
	merchantProcessor _ aMerchantProcessor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'mf 6/9/2022 15:36:45'!
cantDebitFromCreditCardErrorDescription
	
	^'Cant debit from credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'FM 6/7/2022 21:45:40'!
cartHasNoProducts
	^'Cart has no products'.! !

!Cashier class methodsFor: 'error messages' stamp: 'FM 6/7/2022 22:37:07'!
creditCardHasExpired
	^'Credit card has expired'.! !

!Cashier class methodsFor: 'error messages' stamp: 'FM 6/7/2022 22:20:28'!
paymentMethodIsNotCreditCard
	^'Payment method is not a credit card'! !


!Cashier class methodsFor: 'instance creation' stamp: 'FM 6/9/2022 08:51:43'!
workingWith: aMerchantProcessor 
	^self new initializeWorkingWith: aMerchantProcessor ! !


!classDefinition: #CreditCard category: 'TusLibros.com'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate number clientName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!CreditCard methodsFor: 'initialization' stamp: 'mf 6/8/2022 18:02:10'!
initializeWithNumber: aCreditCardNumber clientName: aClientName andExpirationDate: aMonthOfYear
	
	self assertCreditCardNumberHas16Digits: aCreditCardNumber .
	self assertClientNameIsValid: aClientName.
	self assertMonthOfYearIsValid: aMonthOfYear.
	
	number _ aCreditCardNumber.
	clientName _ aClientName.
	expirationDate _ aMonthOfYear 
! !


!CreditCard methodsFor: 'assertions' stamp: 'mf 6/8/2022 17:36:31'!
assertClientNameDoesNotEndWithSpace: aClientName 
	
	(aClientName last = $ ) ifTrue: [self error: CreditCard cardNameEndsWithSpaceErrorDescription]! !

!CreditCard methodsFor: 'assertions' stamp: 'mf 6/8/2022 17:30:38'!
assertClientNameDoesNotStartWithSpace: aClientName 
	
	(aClientName first = $ ) ifTrue: [self error: CreditCard cardNameStartsWithSpaceErrorDescription]! !

!CreditCard methodsFor: 'assertions' stamp: 'mf 6/8/2022 17:41:23'!
assertClientNameIsNotEmpty: aClientName 
	(aClientName isEmpty) ifTrue: [self error: CreditCard cardNameIsEmpty].! !

!CreditCard methodsFor: 'assertions' stamp: 'mf 6/8/2022 17:42:18'!
assertClientNameIsValid: aClientName 
	
	self assertClientNameIsNotEmpty: aClientName.
	self assertClientNameDoesNotStartWithSpace: aClientName.
	self assertClientNameDoesNotEndWithSpace: aClientName! !

!CreditCard methodsFor: 'assertions' stamp: 'mf 6/8/2022 17:41:34'!
assertCreditCardNumberHas16Digits: aCreditCardNumber 
	(aCreditCardNumber size = 16) ifFalse: [self error: CreditCard cardNumberDoesNotHave16Digits]! !

!CreditCard methodsFor: 'assertions' stamp: 'mf 6/8/2022 17:45:48'!
assertMonthOfYearIsValid: aMonthOfAYear 
	
	(aMonthOfAYear class = GregorianMonthOfYear) ifFalse: [self error:
		CreditCard cardExpirationDateMustBeAGregorianMonthOfYearErrorDescrption]! !


!CreditCard methodsFor: 'testing' stamp: 'mf 6/8/2022 18:00:26'!
clientName
	
	^clientName! !

!CreditCard methodsFor: 'testing' stamp: 'mf 6/8/2022 18:01:45'!
expirationDate
	
	^expirationDate! !

!CreditCard methodsFor: 'testing' stamp: 'mf 6/8/2022 17:54:49'!
number
	
	^number! !


!CreditCard methodsFor: 'validation' stamp: 'mf 6/8/2022 18:09:05'!
isExpiredOn: aFixedGregorianDate 
	
	^aFixedGregorianDate > expirationDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FM 6/7/2022 22:44:42'!
withNumber: aCreditCardNumber clientName: aString andExpirationDate: aDate 
	^self new initializeWithNumber: aCreditCardNumber clientName: aString andExpirationDate: aDate ! !


!CreditCard class methodsFor: 'error message' stamp: 'mf 6/8/2022 17:46:50'!
cardExpirationDateMustBeAGregorianMonthOfYearErrorDescrption

	^'Expiration date must be a month of a year'! !

!CreditCard class methodsFor: 'error message' stamp: 'mf 6/8/2022 17:35:58'!
cardNameEndsWithSpaceErrorDescription
	
	^'Name should not end with a space'! !

!CreditCard class methodsFor: 'error message' stamp: 'FM 6/7/2022 22:52:34'!
cardNameIsEmpty
	^'Credit card name is empty'.! !

!CreditCard class methodsFor: 'error message' stamp: 'mf 6/8/2022 17:31:13'!
cardNameStartsWithSpaceErrorDescription
	
	^'Name should not start with a space'! !

!CreditCard class methodsFor: 'error message' stamp: 'FM 6/7/2022 22:48:45'!
cardNumberDoesNotHave16Digits
	^'Card number does not have 16 digits'.! !


!classDefinition: #MerchantProcessor category: 'TusLibros.com'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!MerchantProcessor methodsFor: 'checkout' stamp: 'FM 6/9/2022 09:03:13'!
debit: anAmount to: aCreditCard 
	self subclassResponsibility.! !


!classDefinition: #DecliningMerchantProcessor category: 'TusLibros.com'!
MerchantProcessor subclass: #DecliningMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!DecliningMerchantProcessor methodsFor: 'checkout' stamp: 'FM 6/9/2022 08:57:23'!
cantDebitToCreditCard
	self error: DecliningMerchantProcessor cantDebitToCreditCard.! !

!DecliningMerchantProcessor methodsFor: 'checkout' stamp: 'FM 6/9/2022 08:56:00'!
debit: anAmount to: aCreditCard 
	self cantDebitToCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DecliningMerchantProcessor class' category: 'TusLibros.com'!
DecliningMerchantProcessor class
	instanceVariableNames: ''!

!DecliningMerchantProcessor class methodsFor: 'error messages' stamp: 'FM 6/9/2022 08:57:45'!
cantDebitToCreditCard
	^'Cant debit to credit card'! !


!classDefinition: #WorkingMerchantProcessor category: 'TusLibros.com'!
MerchantProcessor subclass: #WorkingMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!WorkingMerchantProcessor methodsFor: 'checkout' stamp: 'FM 6/9/2022 09:03:51'!
debit: anAmount to: aCreditCard
	
	! !


!classDefinition: #PriceList category: 'TusLibros.com'!
Object subclass: #PriceList
	instanceVariableNames: 'products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros.com'!

!PriceList methodsFor: 'adding' stamp: 'mf 6/7/2022 20:03:59'!
add: aProduct withPrice: aPrice

	self assertAPriceIsValid: aPrice.
	products at: aProduct put: aPrice
	! !


!PriceList methodsFor: 'assertions' stamp: 'mf 6/8/2022 03:28:37'!
assertAPriceIsValid: aPrice 
	
	self assertPriceIsNumber: aPrice.
	self assertPriceIsStrictlyPositive: aPrice! !

!PriceList methodsFor: 'assertions' stamp: 'mf 6/8/2022 03:29:07'!
assertPriceIsNumber: aPrice 
	
	(aPrice isNumber) ifFalse: [self error: PriceList priceIsNotANumber ].! !

!PriceList methodsFor: 'assertions' stamp: 'mf 6/7/2022 19:47:28'!
assertPriceIsStrictlyPositive: aPrice 
	
	(aPrice amount > 0) ifFalse: [self error: PriceList priceIsNotStrictlyPositive]! !


!PriceList methodsFor: 'accesing' stamp: 'mf 6/7/2022 20:04:19'!
includes: aProduct 
	
	^products includesKey: aProduct! !

!PriceList methodsFor: 'accesing' stamp: 'mf 6/7/2022 20:04:57'!
priceOf: aProduct 
	
	^products at: aProduct! !


!PriceList methodsFor: 'initialization' stamp: 'mf 6/7/2022 20:02:03'!
initialize
	
	products _ Dictionary new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PriceList class' category: 'TusLibros.com'!
PriceList class
	instanceVariableNames: ''!

!PriceList class methodsFor: 'error messages' stamp: 'mf 6/8/2022 03:29:14'!
priceIsNotANumber
	
	^'Price must be a number'! !

!PriceList class methodsFor: 'error messages' stamp: 'mf 6/7/2022 19:47:57'!
priceIsNotStrictlyPositive
	
	^'Price must be strictly positive'! !
