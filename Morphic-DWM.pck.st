'From Cuis7.3 [latest update: #7034] on 28 January 2025 at 8:59:58 pm'!
'Description Dynamic tiling window manager for Cuis Smalltalk.'!
!provides: 'Morphic-DWM' 1 85!
SystemOrganization addCategory: #'Morphic-DWM'!


!classDefinition: #DWMTheme category: #'Morphic-DWM'!
Theme subclass: #DWMTheme
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'DWMTheme class' category: #'Morphic-DWM'!
DWMTheme class
	instanceVariableNames: ''!

!classDefinition: #WindowManagerPage category: #'Morphic-DWM'!
Object subclass: #WindowManagerPage
	instanceVariableNames: 'tilingMorph windows'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowManagerPage class' category: #'Morphic-DWM'!
WindowManagerPage class
	instanceVariableNames: ''!

!classDefinition: #WindowManagerMorph category: #'Morphic-DWM'!
BoxMorph subclass: #WindowManagerMorph
	instanceVariableNames: 'pages currentPage ownerExtent highlightedPage'
	classVariableNames: 'Current'
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowManagerMorph class' category: #'Morphic-DWM'!
WindowManagerMorph class
	instanceVariableNames: ''!

!classDefinition: #WindowStackMorph category: #'Morphic-DWM'!
LayoutMorph subclass: #WindowStackMorph
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowStackMorph class' category: #'Morphic-DWM'!
WindowStackMorph class
	instanceVariableNames: ''!

!classDefinition: #WindowTilingMorph category: #'Morphic-DWM'!
LayoutMorph subclass: #WindowTilingMorph
	instanceVariableNames: 'mainWindow stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Morphic-DWM'!
!classDefinition: 'WindowTilingMorph class' category: #'Morphic-DWM'!
WindowTilingMorph class
	instanceVariableNames: ''!


!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 17:58'!
acceptButton
	^ self successColor! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/13/2015 18:23'!
background
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 5/25/2023 19:12:09'!
buttonColorFrom: paneColor
	^ paneColor adjustSaturation: -0.03 brightness: -0.1! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:45'!
buttonLabel
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 17:58'!
cancelButton
	^ self errorColor! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 17:51'!
errorColor
	^ Color lightRed! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 18:01'!
failureColor
	^ Color yellow duller! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:11'!
focusIndicator
	^ self textHighlight lighter! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 03:55'!
listMultiHighlightFocused: aBoolean
	^ (self listHighlightFocused: aBoolean) 
		adjustSaturation: 0.0 brightness: 0.15! !

!DWMTheme methodsFor: 'colors' stamp: 'len 12/27/2022 12:28:29'!
paneBackgroundFrom: aColor
"	^ aColor adjustSaturation: 0 brightness: -0.7"
	^ aColor alphaMixed: 0.14 with: Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:39'!
scrollbarButtonColor
	^Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:58'!
scrollbarColor
	^ Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/14/2015 02:36'!
scrollbarSliderShadowColor
	^Color black! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/14/2023 13:06:53'!
shout
	"
	SHTextStylerST80 releaseClassCachedState
	"
	| green yellow pink blue lilac |
	"fav:"
	yellow := '#F6FA70'.
	blue := '#80DAFF'.
"	blue := '#62CDFF'."
	green := '#B4FF9F'.
	pink := '#FF8AAE'.
"	orange := '#FFCBA3'."
	lilac := '#ACBCFF'.
	"classic:"
"	yellow := '#FFFE82'.
	blue := '#9ED6FF'.
	green := '#ADFFD3'.
	purple := '#FF709C'."
	"fluo:"
"	green := '#A3F307'.
	yellow := '#e2f9e2'.
	purple := '#f50b86'.
	blue := '#05f9e2'."
	"neon:"
"	yellow := '#F6FA70'.
	blue := '#0079FF'.
	green := '#00DFA2'.
	purple := '#FF0060'."

	^ {
		#selector  				-> nil.
		#defaults 				-> #white.
		#undefined 				-> #white. "#(lightRed lighter lighter lighter lighter)."
		#comment 				-> #(lightGray lighter).
		#literals 				-> blue.
		#pseudoVariables 		-> pink. "and bold"
		#messages 				-> #(white).
		#incompleteMessages	-> #(white).
		#arguments 				-> yellow.
		#instVar 				-> lilac.
		#tempBar 				-> #(white darker).
"		#tempVars				-> '#F0FFC4'."
"		#tempVars				-> '#ADFFD3'."
		#tempVars				-> green.
"		#blockTemps				-> '#5CFFA7'."
		#blockTemps				-> green.
"		#block 					-> #(white)."
		#blockLevelZero		-> #(white).
		#blockLevelOne 		-> #(red muchLighter).
		#blockLevelTwo 		-> #(yellow muchLighter).
		#blockLevelThree 		-> #(green muchLighter).
		#blockLevelFour 		-> #(blue muchLighter).
		#blockLevelFive 		-> #(white darker).
		#blockLevelSix 		-> #(white darker).
		#blockLevelSeven 		-> #(white darker).
		#methodTags 			-> #(lightGray lighter). "#(hotPink)"
	}
	
"
		SHTextStylerST80 initialize
" 
! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/9/2016 17:57'!
successColor
	^ Color lightGreen duller! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 03:57'!
text
	^ Color white! !

!DWMTheme methodsFor: 'colors' stamp: 'len 6/14/2023 13:37:17'!
textAutoHighlight
	self flag: #fixme. "this needs to change SHTextStylerST80>>#privateConvert to call it."
	^ (Color colorFrom: '#FF005C') alpha: 0.5
"	^ (Color colorFrom: '#ff2f8e') alpha: 0.5"
"	^ (Color colorFrom: '#F0FF42') alpha: 0.3"! !

!DWMTheme methodsFor: 'colors' stamp: 'len 11/17/2015 23:10'!
textCursor
	^ Color white! !

!DWMTheme methodsFor: 'colors' stamp: 'len 1/25/2025 08:33:08'!
textHighlight
	^ Color gray "Color r: 0.2 g: 0.35 b: 0.45"! !

!DWMTheme methodsFor: 'colors' stamp: 'len 1/25/2025 08:34:16'!
unfocusedTextHighlightFrom: aColor
	^aColor adjustSaturation: 0.0 brightness: -0.08! !

!DWMTheme methodsFor: 'colors' stamp: 'len 3/26/2021 18:09:44'!
windowLabel
	^ `Color gray: 0.2`! !

!DWMTheme methodsFor: 'icons' stamp: 'len 3/27/2021 06:02:22'!
closeIcon
	^ self cancelIcon! !

!DWMTheme methodsFor: 'initialization' stamp: 'len 2/4/2024 20:12:49'!
initialize
	super initialize.
"
	TTFontReader smalltalkAssignmentArrowGlyphCodePoint: 16r2B05.
	TTFontReader smalltalkReturnArrowGlyphCodePoint: 16r2B06.
	
	Preferences name: #showAssignmentAsLeftArrow category: #programming value: true.
	
	TrueTypeFontFamily readAllTrueTypeFontsIn: DirectoryEntry trueTypeFontsDirectory / 'DejaVu' / 'DejaVuSans'.
	PreferenceSet
		setDefaultFont: 'DejaVu Sans'
		spec: #(
			(standardListFont 15)
			(standardMenuFont 15)
			(windowTitleFont 13)
			(standardCodeFont 15)
			(standardButtonFont 15)).
	DisplayScreen runningWorld ifNotNil: [ :world | world fontPreferenceChanged ].
"
	Preferences
		at: #biggerCursors put: false;
		at: #dismissAllOnOptionClose put: true;
		at: #subPixelRenderColorFonts put: true;
		at: #italicsInShout put: true;
		at: #shoutInWorkspaces put: true;
		at: #optionalButtons put: false;
		at: #showAnnotations put: true;
		at: #usePreDebugWindow put: false.

	SHTextStylerST80 initialize.

	Smalltalk garbageCollect.
	WindowManagerMorph new openInWorld startStepping! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:58'!
menu
	^ Color darkGray darker darker! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:58'!
menuText
	^ Color white! !

!DWMTheme methodsFor: 'menu colors' stamp: 'len 11/17/2015 03:59'!
menuTitleBar
	^ self menu darker! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 23:33:07'!
buttonBorderWidth
	^ 1! !

!DWMTheme methodsFor: 'other options' stamp: 'len 8/5/2022 08:26:40'!
buttonPaneHeight
	"Answer the user's preferred default height for button panes."

	^(Preferences at: #standardButtonFont) lineSpacing * 10 // 8! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 17:18:00'!
embossedButtonLabels
	^ false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 17:27:46'!
embossedTitles
	^ false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 01:23'!
fullScreenDeskMargin
	^ 0! !

!DWMTheme methodsFor: 'other options' stamp: 'len 3/24/2021 15:19:57'!
layoutAdjusterThickness
	^ 2! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 23:23:46'!
roundButtons
	^ true! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 17:26:06'!
roundWindowCorners
	^ true! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 23:51:17'!
roundedButtonRadius
	^ 4! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 17:26:43'!
roundedWindowRadius
	^6! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 17:19:14'!
scrollbarShowButtons
	^ false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 23:49:27'!
scrollbarThickness
	^ 16! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/16/2015 00:10'!
useTaskbar
	^false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 11/17/2015 22:36'!
useUniformColors
	^false! !

!DWMTheme methodsFor: 'other options' stamp: 'len 5/24/2023 17:09:29'!
windowBorderWidth
	^ 6! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:56:15'!
browser
	^ Color lightGreen duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:47:12'!
changeList
	^ Color lightCyan duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:26:06'!
changeSorter
	^ Color lightCyan duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/22/2020 18:08:30'!
debugger
	^ Color lightRed darker! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 11/16/2015 02:16'!
defaultWindowColor
	^ Color gray darker! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 20:03:55'!
fileContentsBrowser
	^ Color tan! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:21:54'!
fileList
	^ Color lightMagenta duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:56:27'!
messageNames
	^ Color lightBlue duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:56:35'!
messageSet
	^ Color lightBlue duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 20:03:15'!
packageList
	^ Color tan! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 20:06:47'!
testRunner
	^ Color blue quiteWhiter duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 6/25/2016 20:25'!
transcript
	^ Color lightOrange! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:35:48'!
versionsBrowser
	^ Color pink whiter duller! !

!DWMTheme methodsFor: 'tool colors' stamp: 'len 5/26/2020 19:42:16'!
workspace
	^ Color lightYellow duller! !

!DWMTheme methodsFor: 'widget colors' stamp: 'len 11/13/2015 19:11'!
textPane
	^ Color black! !

!DWMTheme methodsFor: 'private - shout mappings' stamp: 'len 12/18/2022 09:57:31'!
generateShoutConfig

	| styles colors |
	styles := OrderedCollection new.
	colors := self shout as: Dictionary.

	{
		{self undefined. colors at: #undefined}.
		{self defaults . colors at: #defaults}.
		{self pseudoVariables . colors at: #pseudoVariables. #bold}.
		{self literals . colors at: #literals}.
		{self instVar . colors at: #instVar}.
		{self messages . colors at: #messages}.
		{self blockLevelZero . colors at: #blockLevelZero}.
		{self blockLevelOne . colors at: #blockLevelOne}.
		{self blockLevelTwo . colors at: #blockLevelTwo}.
		{self blockLevelThree . colors at: #blockLevelThree}.
		{self blockLevelFour . colors at: #blockLevelFour}.
		{self blockLevelFive . colors at: #blockLevelFive}.
		{self blockLevelSix . colors at: #blockLevelSix}.
		{self blockLevelSeven . colors at: #blockLevelSeven}.
		{self tempBar . colors at: #tempBar}.
		{self methodTags . colors at: #methodTags . #bold}.
		{self globals . colors at: #defaults . #bold}.
		{self incompleteMessages . colors at: #incompleteMessages . #underlined}.
		{self argumentTypes . colors at: #arguments . self italic}.
		{self symbols . colors at: #messages . #bold}.
		{self pattern . colors at: #selector . #bold}.
		{self ansiAssignment . nil . #bold}.
		{self assignment . nil . #bold}.
		{self return . nil . #bold}.
		{self tempVars . colors at: #tempVars . self italic}.
		{self blockTemps . colors at: #blockTemps . self italic}
	} do: [ :style |
		styles addAll:
			(style first
				collect: [ :category | | elements |
					elements _ style asOrderedCollection.
					elements at: 1 put: category.
					Array withAll: elements ])].

	"Miscellaneous remainder after factoring out commonality:"
	styles addAll: {
		{#unfinishedString . colors at: #undefined . #normal}.
		{#undefinedIdentifier . colors at: #undefined .#bold}.
		{#unfinishedComment . colors at: #undefined . self italic}.
		{#comment . colors at: #comment . self italic}.
		{#string . colors at: #literals . #normal}.
		{#literal . nil . self italic}.
		{#incompleteIdentifier . colors at: #incompleteMessages . {#italic. #underlined}}.
		{#classVar . colors at: #instVar . #bold}.
	}.

	^ styles! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 5/5/2018 19:08:29'!
flash
	tilingMorph ifNotNil: [:aMorph| aMorph world ifNotNil: [:aWorld| aWorld flash. ^ self]].
	windows do: [:each| each world ifNotNil: [:aWorld| aWorld flash. ^ self]]! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 7/10/2016 08:52'!
hide
	tilingMorph notNil ifTrue: [tilingMorph visible: false].
	windows do: [:each | (each owner notNil and: [each isReallyVisible]) ifTrue: [each removeHalo; visible: false]]! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 11/17/2015 02:50'!
show
	tilingMorph notNil ifTrue: [tilingMorph visible: true].
	windows do: [:each | each visible ifFalse: [each visible: true]]! !

!WindowManagerPage methodsFor: 'actions' stamp: 'len 1/25/2025 08:29:47'!
windowToggleTiling: aSystemWindow windowsArea: windowsArea
	| possibleBounds |
	aSystemWindow isInWorld ifFalse: [^ self].
	aSystemWindow removeHalo.
	tilingMorph isNil
		ifTrue:
			[tilingMorph := WindowTilingMorph newRow.
			aSystemWindow world addMorphBack: tilingMorph.
			self updateBounds: windowsArea].
	aSystemWindow owner == aSystemWindow world
		ifTrue:
			[aSystemWindow setProperty: #floatingBounds toValue: aSystemWindow displayBounds.
			tilingMorph addWindow: aSystemWindow]
		ifFalse:
			[aSystemWindow world addMorphFront: aSystemWindow.
			possibleBounds := aSystemWindow valueOfProperty: #floatingBounds.
			aSystemWindow removeProperty: #floatingBounds.
			aSystemWindow position: possibleBounds topLeft extent: possibleBounds extent].
	tilingMorph refresh.
	tilingMorph hasSubmorphs ifFalse: [tilingMorph delete. tilingMorph := nil]! !

!WindowManagerPage methodsFor: 'events' stamp: 'len 11/17/2015 23:05'!
windowClosed: aSystemWindow
	windows remove: aSystemWindow ifAbsent: [].
	self refresh! !

!WindowManagerPage methodsFor: 'events' stamp: 'len 11/17/2015 02:28'!
windowOpen: aSystemWindow
	windows add: aSystemWindow.
	self refresh! !

!WindowManagerPage methodsFor: 'initialization' stamp: 'len 5/22/2020 09:15:31'!
delete
	tilingMorph ifNotNil: [tilingMorph delete. tilingMorph _ nil]! !

!WindowManagerPage methodsFor: 'initialization' stamp: 'len 11/16/2015 15:00'!
initialize
	windows _ OrderedCollection new! !

!WindowManagerPage methodsFor: 'printing' stamp: 'len 11/16/2015 15:36'!
printOn: aStream
	aStream nextPut: $[.
	windows do: [:each | aStream print: each] separatedBy: [aStream nextPutAll: '; '].
	aStream nextPut: $]! !

!WindowManagerPage methodsFor: 'testing' stamp: 'len 5/3/2018 21:06:42'!
isEmpty
	^ windows isEmpty! !

!WindowManagerPage methodsFor: 'private' stamp: 'len 11/17/2015 02:30'!
refresh
	tilingMorph isNil ifTrue: [^ self].
	tilingMorph refresh.
	tilingMorph hasSubmorphs ifFalse: [tilingMorph delete].
	tilingMorph isInWorld ifFalse: [tilingMorph _ nil]! !

!WindowManagerPage methodsFor: 'private' stamp: 'len 5/22/2020 09:02:53'!
updateBounds
	self runningWorld submorphs do: [:one| (one isKindOf: WindowManagerMorph) ifTrue: [^ self updateBounds: one windowsArea]]! !

!WindowManagerPage methodsFor: 'private' stamp: 'len 1/25/2025 08:29:33'!
updateBounds: windowsArea
	tilingMorph ifNotNil: [tilingMorph position: windowsArea topLeft extent: windowsArea extent].
	windows do: [:each| (each hasProperty: #originalBounds) ifTrue: [each position: windowsArea topLeft extent: windowsArea extent]]
! !

!WindowManagerMorph methodsFor: 'actions' stamp: 'len 5/22/2020 10:33:53'!
moveWindow: aSystemWindow toPage: anInteger
	| newPage |
	newPage _ pages at: anInteger.
	newPage == currentPage ifTrue: [^ self].
	(aSystemWindow hasProperty: #floatingBounds) ifTrue: [^ self].

	currentPage windowClosed: aSystemWindow.
	aSystemWindow removeHalo.
	aSystemWindow visible: false.
	newPage windowOpen: aSystemWindow.
	
	self step.
	self redrawNeeded! !

!WindowManagerMorph methodsFor: 'actions' stamp: 'len 5/22/2020 10:33:39'!
switchToPage: anInteger
	| newPage |
	newPage _ pages at: anInteger.
	currentPage == newPage ifTrue: [^ self].
"	newPage isEmpty ifTrue: [^ currentPage flash]."
	currentPage hide.
	currentPage _ newPage.
	currentPage show.
	self step.
	self redrawNeeded! !

!WindowManagerMorph methodsFor: 'actions' stamp: 'len 6/6/2023 08:15:22'!
windowToggleTiling: aSystemWIndow
	currentPage windowToggleTiling: aSystemWIndow windowsArea: self windowsArea! !

!WindowManagerMorph methodsFor: 'drawing' stamp: 'len 1/25/2025 08:22:37'!
drawOn: aCanvas
	| font w rect |
	aCanvas fillRectangle: self localBounds color: (Color white alpha: 0.15).
	font := self font.
	w := font lineSpacing.
	rect := 0@0 extent: w@w.
	pages withIndexDo: [:page :i|
		page == currentPage
			ifTrue: [aCanvas fillRectangle: (rect insetBy: 1) color: Color black].
		i = highlightedPage
			ifTrue: [aCanvas frameRectangle: (rect insetBy: 1) borderWidth: 1 color: Color white].
		aCanvas
			drawString: i printString
			at: rect topLeft + (4@1)
			font: font
			color: (page == currentPage ifTrue: [Color white] ifFalse: [page isEmpty ifTrue: [Color black] ifFalse: [Color gray]]).
		rect := rect translatedBy: w@0].
"	activeWindowLabel ifNotNil:
		[:aString|
		aCanvas drawString: activeWindowLabel asString
			at: rect topRight + (w@1)
			font: font
			color: Color black]"! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 6/6/2023 08:33:14'!
handlesMouseDown: evt
	^ true! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 6/6/2023 12:46:57'!
handlesMouseHover
	^ true! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 6/6/2023 12:38:16'!
handlesMouseOver: evt
	^ true! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 1/25/2025 08:48:36'!
keyStroke: aKeyboardEvent morph: aMorph
	"Handle global shortcuts. Return true if the event was handled, false otherwise."
	"Global shortcuts should use command (Mac) / alt (PC) key.
	Control key is reserved for normal shortcuts (local shortcuts, defined by a morph), except ctrl-esc for the world menu."

	| i |
	aKeyboardEvent controlKeyPressed ifTrue:
		[aKeyboardEvent isEsc ifTrue: [self world mouseButton2Activity. ^true]. ^false]. "open world menu"
	aKeyboardEvent commandAltKeyPressed ifFalse: [^false].
	aKeyboardEvent isEsc
		ifTrue: [aMorph owningWindow ifNotNil: [:w| w fullScreen. ^true]].
	aKeyboardEvent keyCharacter = $w
		ifTrue: [aMorph owningWindow ifNotNil: [:w| w delete. ^true]].
	aKeyboardEvent keyCharacter = $t
		ifTrue: [aMorph owningWindow ifNotNil: [:w| self windowToggleTiling: w. ^true]].

	(aKeyboardEvent keyValue between: $1 asciiValue and: $8 asciiValue)
		ifTrue: [self switchToPage: aKeyboardEvent keyValue - $1 asciiValue + 1. ^true].
	(i := #(33 64 35 36 37 94 38 42) indexOf: aKeyboardEvent keyValue) > 0
		ifTrue: [aMorph owningWindow ifNotNil: [:w| self moveWindow: w toPage: i; switchToPage: i. ^true]].

	"Shortcuts to open new windows:"
	aKeyboardEvent keyCharacter = $B
		ifTrue: [Browser open. ^true].
	aKeyboardEvent keyCharacter = $W
		ifTrue: [Workspace open. ^true].
	aKeyboardEvent keyCharacter = $T
		ifTrue: [Transcript open. ^true].
	aKeyboardEvent keyCharacter = $P
		ifTrue: [CodePackageList open. ^true].
	aKeyboardEvent keyCharacter = $F
		ifTrue: [FileList open. ^true].
	aKeyboardEvent keyCharacter = $C
		ifTrue: [ChangeSorter open. ^true].
	aKeyboardEvent keyCharacter = $S
		ifTrue: [TestRunner open. ^true].
	aKeyboardEvent keyCharacter = $M
		ifTrue: [MessageNames open. ^true].
	^ false! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 6/6/2023 08:32:04'!
mouseButton1Up: aMouseButtonEvent localPosition: localEventPosition
	| pageNumber |
	pageNumber := (localEventPosition x // self font lineSpacing) rounded + 1.
	(pageNumber between: 1 and: 8) ifTrue: [self switchToPage: pageNumber]! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 6/6/2023 12:57:16'!
mouseHover: aMouseMoveEvent localPosition: localEventPosition
	| i |
	((i := (localEventPosition x // self defaultHeight + 1) rounded) between: 1 and: 8) ifTrue:
		[highlightedPage := i.
		self redrawNeeded].! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 6/6/2023 12:54:23'!
mouseLeave: evt
	highlightedPage := nil.
	self redrawNeeded! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 5/22/2020 08:43:45'!
windowClosed: aSystemWindow
	currentPage windowClosed: aSystemWindow.
"	currentPage isEmpty ifTrue:
		[| currentIndex |
		currentIndex _ pages indexOf: currentPage.
		(currentIndex - 1 to: 1 by: -1), (currentIndex + 1 to: pages size)
			do: [:i| (pages at: i) isEmpty ifFalse: [^ self switchToPage: i]]]"! !

!WindowManagerMorph methodsFor: 'events' stamp: 'len 1/28/2022 12:33:32'!
windowOpen: aSystemWindow
	currentPage windowOpen: aSystemWindow.
"	aSystemWindow addHalo"! !

!WindowManagerMorph methodsFor: 'initialization' stamp: 'len 1/25/2025 08:23:08'!
initialize
	super initialize.
	pages := (1 to: 8) collect: [:each | WindowManagerPage new].
	currentPage := pages first! !

!WindowManagerMorph methodsFor: 'initialization' stamp: 'len 5/22/2020 09:15:01'!
reset
	pages do: [:each| each delete].
	pages _ (1 to: 8) collect: [:each | WindowManagerPage new].
	currentPage _ pages first.
	SystemWindow allSubInstances do: [:each|each isInWorld ifTrue: [self addWindow: each]]! !

!WindowManagerMorph methodsFor: 'stepping' stamp: 'len 1/28/2022 15:41:29'!
step
	| newOwnerExtent |
	self comeToFront.
	newOwnerExtent _ owner morphExtent.
	ownerExtent = newOwnerExtent ifFalse: [self updateBounds. ownerExtent _ newOwnerExtent]! !

!WindowManagerMorph methodsFor: 'stepping' stamp: 'len 1/28/2022 12:29:04'!
stepTime
	^ 1000! !

!WindowManagerMorph methodsFor: 'submorphs-accessing' stamp: 'len 1/28/2022 15:40:05'!
noteNewOwner: aMorph
	"I have just been added as a submorph of aMorph"
	Current ifNotNil: [:m| Current delete].
	Current _ self.
	super noteNewOwner: aMorph.
	self reset.
	self updateBounds! !

!WindowManagerMorph methodsFor: 'submorphs-add/remove' stamp: 'len 1/28/2022 15:39:38'!
delete
	pages do: [:each| each delete].
	super delete.
	Current == self ifTrue: [Current _ nil]! !

!WindowManagerMorph methodsFor: 'testing' stamp: 'len 5/19/2020 12:23:50'!
isSticky
	^true! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 08:41:44'!
addWindow: aSystemWindow
	currentPage windowOpen: aSystemWindow! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/22/2020 07:53:35'!
defaultHeight
	^ self font lineSpacing! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 6/6/2023 08:39:35'!
defaultWidth
	^ self defaultHeight * 8 + 2! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 6/6/2023 12:57:48'!
font
	^ (FontFamily familyNamed: FontFamily defaultFamilyName) atPointSize: 16! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 1/25/2025 08:24:40'!
updateBounds
	| world newPosition area |
	world := self world ifNil: [^ self].
	newPosition := world morphWidth - self defaultWidth @ (world morphHeight - self defaultHeight).
	self morphPosition rounded = newPosition rounded ifTrue: [^ self].
	self position: newPosition extent: self defaultWidth @ self defaultHeight.
	area := self windowsArea.
	pages do: [:each| each updateBounds: area]! !

!WindowManagerMorph methodsFor: 'private' stamp: 'len 5/25/2020 08:07:35'!
windowsArea
	| allowedArea |
	allowedArea _ Display boundingBox.
	self world ifNotNil: [:w| allowedArea _ allowedArea intersect: w viewBox].
	^allowedArea! !

!WindowManagerMorph class methodsFor: 'as yet unclassified' stamp: 'len 5/22/2020 08:33:15'!
current
	^ Current! !

!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/18/2015 03:14'!
privateAddMorph: aMorph atIndex: anInteger
	aMorph owner == self ifTrue: [^ self].
	super privateAddMorph: aMorph atIndex: anInteger! !

!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 3/24/2021 15:15:44'!
privateMoveFrontMorph: aMorph
	aMorph owner == self ifTrue: [^ self].
	^ super privateMoveFrontMorph: aMorph! !

!WindowStackMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 05:57'!
removedMorph: aMorph
	super removedMorph: aMorph.
"	owner notNil ifTrue: [owner stackChanged]."
	self layoutSubmorphs! !

!WindowTilingMorph methodsFor: 'initialization' stamp: 'len 11/19/2015 07:24'!
initialize
	super initialize.
	self sticky: true! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 05:58'!
addMorphBack: aMorph
	aMorph owner == self ifTrue: [^ self].
	^ super addMorphBack: aMorph! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 04:31'!
addMorphFront: aMorph
	aMorph owner == self ifTrue: [^ self]. "we do this to avoid system windows to come to front (and change the desired order wrt the stack) when clicking on them"
	^ super addMorphFront: aMorph! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/16/2015 05:45'!
addWindow: aSystemWindow
	aSystemWindow layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1).
	self addMorphBack: aSystemWindow.
	mainWindow notNil ifTrue: [self pushWindow].
	mainWindow _ aSystemWindow.! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/18/2015 03:15'!
privateAddMorph: aMorph atIndex: anInteger
	aMorph owner == self ifTrue: [^ self].
	super privateAddMorph: aMorph atIndex: anInteger! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 3/24/2021 15:14:40'!
privateMoveBackMorph: aMorph
	aMorph owner == self ifTrue: [^ self]. "we do this to avoid system windows to come to front (and change the desired order wrt the stack) when clicking on them"
	^ super privateMoveBackMorph: aMorph! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 3/24/2021 15:14:02'!
privateMoveFrontMorph: aMorph
	aMorph owner == self ifTrue: [^ self]. "we do this to avoid system windows to come to front (and change the desired order wrt the stack) when clicking on them"
	^ super privateMoveFrontMorph: aMorph! !

!WindowTilingMorph methodsFor: 'submorphs-add/remove' stamp: 'len 11/17/2015 05:56'!
removedMorph: aMorph
	aMorph == mainWindow
		ifTrue: [mainWindow _ nil]
		ifFalse: [aMorph == stack ifTrue: [stack _ nil]]! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 11/16/2015 13:45'!
popWindow
	"There's no main window, pop a window from the stack and set it as main window."
	stack isNil ifTrue: [^ self].
	mainWindow _ stack submorphs detect: [:one | one is: #SystemWindow] ifNone: [].
	mainWindow isNil ifTrue: [^ self removeStack].
	self addMorphBack: mainWindow.
	stack hasSubmorphs ifFalse: [self removeStack]! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 11/17/2015 03:35'!
pushWindow
	"Make room available for a new main window. Push the current main window to the stack."
	mainWindow isNil ifTrue: [^ self].
	stack isNil
		ifTrue:
			[stack _ direction == #vertical
				ifTrue: [WindowStackMorph newRow layoutSpec: (LayoutSpec proportionalWidth: 1 proportionalHeight: 1); yourself]
				ifFalse: [WindowStackMorph newColumn layoutSpec: (LayoutSpec proportionalWidth: 0.8 proportionalHeight: 1); yourself].
			stack color: self color.
			self addMorphFront: stack].
	stack addMorphBack: mainWindow! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 5/22/2020 09:13:49'!
refresh
	mainWindow isNil ifTrue: [self popWindow].
	stack isNil ifFalse: [stack hasSubmorphs not ifTrue: [self removeStack]].
	stack isNil ifFalse: [stack layoutSubmorphs].
	self layoutSubmorphs! !

!WindowTilingMorph methodsFor: 'private' stamp: 'len 11/16/2015 04:38'!
removeStack
	stack isNil ifTrue: [^ self].
	stack delete.
	stack _ nil! !

!KeyboardEvent methodsFor: '*morphic-dwm-dispatching' stamp: 'len 3/24/2021 12:49:16'!
sendEventTo: aMorph
	"Dispatch the receiver into aMorph."
	type == #keystroke
		ifTrue:
			[^ (WindowManagerMorph current ifNotNil: [:m| m keyStroke: self morph: aMorph] ifNil: [false])
				ifFalse: [aMorph processKeystroke: self]].
	type == #keyDown ifTrue: [^ aMorph processKeyDown: self].
	type == #keyUp ifTrue: [^ aMorph processKeyUp: self].
	^ super sendEventTo: aMorph! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 6/6/2023 08:23:07'!
addWindowControlTo: aMenu

	aMenu
		add: 'send to back' 				action: #sendToBack 				icon: #goBottomIcon;
		add: 'make next-to-topmost' 	action: #makeSecondTopmost 	icon: #goUpIcon;
		addLine;
		add: (self isSticky ifTrue: [ 'make draggable' ] ifFalse: [ 'make undraggable' ])
											action: #toggleStickiness 			icon: (self isSticky ifFalse: [#pushPinIcon]);
		addLine;
		add: 'close (w)' 						action: #delete 						icon: #closeIcon;
		add: 'tille / untile (t)' 					action: #toggleTiling 					icon: #collapseIcon;
		add: 'expand / contract (esc)' 		action: #expandBoxHit 				icon: #expandIcon;
		addLine;
		add: 'resize...' 					action: #resize.
		
	^aMenu! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 6/6/2023 08:10:30'!
buildWindowMenu

	| aMenu |

	aMenu := MenuMorph new defaultTarget: self.

	aMenu 
		add: 'change title...' 			action: #relabel 						icon: #saveAsIcon;
		add: 'window color...' 			action: #setWindowColor 			icon: #graphicsIcon.
	
	self hasSaveAs
		ifTrue: [ aMenu add: 'Save as ...' action: #saveContents icon: #saveAsIcon ].
		
	aMenu
		addLine.
		
	self addWindowControlTo: aMenu.
"	self addTileResizerMenuTo: aMenu."

	^ aMenu! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 6/6/2023 08:24:07'!
createCloseButton
	^ (PluggableButtonMorph model: self action: #closeBoxHit)
		iconDrawSelector: #drawCloseIcon;
		setBalloonText: 'close this window (w)';
		morphExtent: Theme current titleBarButtonsExtent;
		color: Color transparent;
		borderWidth: 0! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 6/6/2023 08:25:07'!
createExpandButton
	^ (PluggableButtonMorph model: self action: #expandBoxHit)
		iconDrawSelector: #drawExpandIcon;
		setBalloonText: 'expand / contract this window (esc)';
		morphExtent: Theme current titleBarButtonsExtent;
		color: Color transparent;
		borderWidth: 0! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 6/6/2023 08:25:17'!
createTileButton
	^(PluggableButtonMorph model: self action: #toggleTiling)
		iconDrawSelector: #drawCollapseIcon;
		setBalloonText: 'tile / untile this window (t)';
		morphExtent: Theme current titleBarButtonsExtent;
		color: Color transparent;
		borderWidth: 0! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 5/22/2020 08:59:41'!
delete
	| thisWorld |
	(self canDiscardEditsOf: self) ifFalse: [^self].
	thisWorld := self world.
	SystemWindow noteTopWindowIn: thisWorld but: self.
	self sendToBack.
	self removeHalo.
	super delete.
	self model: nil.
	WindowManagerMorph current ifNotNil: [:m| m windowClosed: self]! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 6/6/2023 08:22:15'!
initializeLabelArea
	"Initialize the label area (titlebar) for the window."

	| topLeft spacing |
	topLeft := (self labelHeight + borderWidth - Theme current titleBarButtonsExtent / 2) ceiling asPoint.
	spacing := Theme current titleBarButtonsExtent x *13//10.
	self addMorph: self createCloseButton position: topLeft.
	self addMorph: self createTileButton position: spacing@0 + topLeft.
	self addMorph: self createExpandButton position: spacing*2@0 + topLeft.
	self addMorph: self createMenuButton position: spacing*3@0 + topLeft! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 5/22/2020 09:00:26'!
openInWorld
	"Ensure all widgets have proper colors before opening"
	Theme current widgetsColorFromToolColor ifTrue: [
		self widgetsColor: self windowColor ].
	super openInWorld.
	WindowManagerMorph current ifNotNil: [:m| m windowOpen: self]! !

!SystemWindow methodsFor: '*morphic-dwm' stamp: 'len 6/6/2023 08:19:17'!
toggleTiling
	WindowManagerMorph current ifNotNil: [:m| m windowToggleTiling: self]! !

!RealEstateAgent class methodsFor: '*morphic-dwm' stamp: 'len 5/30/2020 16:27:52'!
screenTopSetback
	^ 16! !
