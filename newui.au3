;another fast hack by UEZ 2011
#include <GDIPlus.au3>
#include <WindowsConstants.au3>


Opt("GUIOnEventMode", 1)
_GDIPlus_Startup()

#include <Inet.au3>
#include <String.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <WinAPIFiles.au3>
#include <StaticConstants.au3>
$sListOfChampions = "Aatrox|Ahri|Akali|Alistar|Amumu|Anivia|Annie|Ashe|Aurelion Sol|Azir|Bard|Blitzcrank|Brand|Braum|Caitlyn|Cassiopeia|Cho'Gath|Corki|Darius|Diana|Dr. Mundo|Draven|Ekko|Elise|Evelynn|Ezreal|Fiddlesticks|Fiora|Fizz|Galio|Gangplank|Garen|Gnar|Gragas|Graves|Hecarim|Heimerdinger|Illaoi|Irelia|Janna|Jarvan IV|Jax|Jayce|Jhin|Jinx|Kalista|Karma|Karthus|Kassadin|Katarina|Kayle|Kennen|Kha'Zix|Kindred|Kog'Maw|LeBlanc|Lee Sin|Leona|Lissandra|Lucian|Lulu|Lux|Malphite|Malzahar|Maokai|Master Yi|Miss Fortune|Mordekaiser|Morgana|Nami|Nasus|Nautilus|Nidalee|Nocturne|Nunu|Olaf|Orianna|Pantheon|Poppy|Quinn|Rammus|Rek'Sai|Renekton|Rengar|Riven|Rumble|Ryze|Sejuani|Shaco|Shen|Shyvana|Singed|Sion|Sivir|Skarner|Sona|Soraka|Swain|Syndra|Tahm Kench|Talon|Taric|Teemo|Thresh|Tristana|Trundle|Tryndamere|Twisted Fate|Twitch|Udyr|Urgot|Varus|Vayne|Veigar|Vel'Koz|Vi|Viktor|Vladimir|Volibear|Warwick|Wukong|Xerath|Xin Zhao|Yasuo|Yorick|Zac|Zed|Ziggs|Zilean|Zyra"

Local Const $SC_DRAGMOVE = 0xF012
Local Const $W = -1
Local Const $H = 200
Local Const $hGUI = GUICreate("GDI+ Test by UEZ 2011", $W, $H, -1, -1, $WS_POPUP, $WS_EX_LAYERED)
Local Const $hGUI_Child = GUICreate("", $W, $H, 0, 0, $WS_POPUP, $WS_EX_MDICHILD + $WS_EX_LAYERED + $WS_EX_TOOLWINDOW, $hGUI)
GUISetBkColor(0xABCDEF, $hGUI_Child)
GUISwitch($hGUI_Child)
Local Const $idButton = GUICtrlCreateButton("Exit", 40, 20, 100, 40)
GUICtrlSetOnEvent(-1, "_Exit")
Local Const $idLabel = GUICtrlCreateLabel("TEST LABEL HERE!!!", 110, 140, 180, 20)
GUICtrlSetFont(-1, 14, 400, 0, "Times New Roman", 3)
GUICtrlSetColor(-1, 0xF0F0FF)
GUICtrlSetBkColor(-1, -2)
_WinAPI_SetLayeredWindowAttributes($hGUI_Child, 0xABCDEF, 0xFF)


	Local $iChampionSelection = GUICtrlCreateCombo("Champion", 215, 25, 150, 20)
	GUICtrlSetOnEvent($iChampionSelection, "_Do")
	GUICtrlSetData($iChampionSelection, $sListOfChampions)
GUISetState(@SW_SHOW, $hGUI_Child)
GUISetState(@SW_SHOW, $hGUI)
_SetGuiRoundCorners($hGUI, 40, False, True, True, False)

Local Const $hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
Local Const $hBitmap = _CreateCustomBk($hGUI, 0x550555)
Local Const $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_CreateCustomGroupPic($hContext, 100, 100, 200, 75, 0xff0000)
_GDIPlus_GraphicsDrawImageRect($hGraphic, $hBitmap, 0, 0, $W, $H)

SetTransparentBitmap($hGUI, $hBitmap, 0xD0)

GUISetOnEvent(-3, "_Exit")

GUIRegisterMsg($WM_LBUTTONDOWN, "_WM_LBUTTONDOWN")

While Sleep(2 ^ 16)

WEnd
Local $sChampion

Func _Do()
	$sChampion = GUICtrlRead($iChampionSelection)
	If $sChampion <> "Champion" Then
		GetCounterInfo($sChampion)
	EndIf
EndFunc


Func GetCounterInfo($sChampion)


;~ ;===Modify Champion selected for use in URL===
	;Removes spaces and periods
	$sChampion = StringReplace(StringReplace($sChampion, " ", ""), ".", "")
	;Removes apostrohpe in Champion names (ie. Vel'Koz, Cho'Gath)
	If StringInStr($sChampion,"'") Then
		$sChampion = StringReplace($sChampion, "'", "")
		$sChampion = StringLeft($sChampion,1) & StringLower(StringMid($sChampion,2))
	EndIf

	$sWeak = _INetGetSource('http://www.lolcounter.com/champions/' & $sChampion & '/weak')
	$sStrong = _INetGetSource('http://www.lolcounter.com/champions/' & $sChampion & '/strong')
	$sMostFrequentMastery = _INetGetSource('https://champion.gg/champion/' & $sChampion)

	$aBetweenWeak = _StringBetween($sWeak, "a class='left' href='/champions/", "'><div")
	$aBetweenStrong = _StringBetween($sStrong, "a class='left' href='/champions/", "'><div")


	$aMasteryList = _StringBetween($sMostFrequentMastery, ' mastery-active" champion-tip api-type="masteries" api-primary-id="',  '" api-secondary-id="')





	$idListview = GUICtrlCreateListView("", 2, 2, 210, 425)

  ; Enable extended control styles
    _GUICtrlListView_SetExtendedListViewStyle($idListview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))



	Local  $STM_SETIMAGE = 0x0172


	Local $hChampionBmp = _GDIPlus_BitmapCreateFromMemory(InetRead("https://ddragon.leagueoflegends.com/cdn/6.8.1/img/champion/" & $sChampion & ".png"), True) ;to load an image from the net
	Local  $hChampionBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hChampionBmp)


	Local  $iWidth = _GDIPlus_ImageGetWidth($hChampionBitmap)
	Local  $iHeight = _GDIPlus_ImageGetHeight($hChampionBitmap)
	MsgBox(0,"","")
	Local  $idChampionPic = GUICtrlCreatePic("", 250, 150, $iWidth, $iHeight)

	MsgBox(0,"","")
	_WinAPI_DeleteObject(GUICtrlSendMsg($idChampionPic, $STM_SETIMAGE, $IMAGE_BITMAP, $hChampionBmp))

	Local $sMasteryURL = ""
	Local $aFrequentMasteryList[10]
	Local $aMostWinsMasteryList[10]


;~ 	Find/Load KeystoneMastery images

	For $i = 0 To UBound($aMasteryList)/2 - 1

		$aFrequentMasteryList[$i] = $aMasteryList[$i]
		$aMostWinsMasteryList[$i] = $aMasteryList[$i+5]
	Next



;~ 	GUICtrlCreateLabel("Frequent Keystone Mastery: ",230, 50,50,40, $SS_CENTERIMAGE)
GUICtrlCreateLabel("Frequent Keystone Mastery: ", 200, 10, 150, 17)
	$sFrequentKeystone = GetMasteryKeystoneInfo($aFrequentMasteryList)
	If $sFrequentKeystone <> "" Then
		GetPNGFromURL($sFrequentKeystone, 250, 150)
	EndIf

	$sMostWinKeystone = GetMasteryKeystoneInfo($aMostWinsMasteryList)
	If $sMostWinKeystone <> "" Then
		GetPNGFromURL($sMostWinKeystone, 250, 250)
	EndIf









    ; Load images
	$hImage = _GUIImageList_Create()
    _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0xFF0000, 16, 16))
    _GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap(GUICtrlGetHandle($idListview), 0x00FF00, 16, 16))

    _GUICtrlListView_SetImageList($idListview, $hImage, 1)

    ; Add columns
    _GUICtrlListView_AddColumn($idListview, "WEAK", 100)
    _GUICtrlListView_AddColumn($idListview, "STRONG", 100)



    ; Add items
	For $i = 0 To UBound($aBetweenWeak) - 1
		_GUICtrlListView_AddItem($idListview, $aBetweenWeak[$i])
		For $j = 0 To UBound($aBetweenStrong) - 1
			_GUICtrlListView_AddSubItem($idListview, $j, $aBetweenStrong[$j], 1, 1)
		Next
	Next
EndFunc

Func GetMasteryKeystoneInfo($aMasteryList)

	Local $sMasteryURL
	For $i = 0 To UBound($aMasteryList) - 1
		Switch $aMasteryList[$i]
			;Ferocity Tree
			Case "6161" ;Warlord's Bloodlust
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/6/6d/Mastery_Warlord%27s_Bloodlust.png/50px-Mastery_Warlord%27s_Bloodlust.png'
			Case "6162" ;Fervor of Battle
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/4/4b/Mastery_Fervor_of_Battle.png/50px-Mastery_Fervor_of_Battle.png'
			Case "6164" ;Deathfire Touch
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/5/5e/Mastery_Deathfire_Touch.png/50px-Mastery_Deathfire_Touch.png'

			;Cunning Tree
			Case "6361" ;Stormraider's Surge
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/a/aa/Mastery_Stormraider%27s_Surge.png/50px-Mastery_Stormraider%27s_Surge.png'
			Case "6362" ;Thunderlord's Decree
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/8/84/Mastery_Thunderlord%27s_Decree.png/50px-Mastery_Thunderlord%27s_Decree.png'
			Case "6363" ;Windspeaker's Blessing
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/7/71/Mastery_Windspeaker%27s_Blessing.png/50px-Mastery_Windspeaker%27s_Blessing.png'

			;Resolve Tree
			Case "6261" ;Grasp of the Undying
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/a/a0/Mastery_Grasp_of_the_Undying.png/50px-Mastery_Grasp_of_the_Undying.png'
			Case "6262" ;Strength of the Ages
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/6/60/Mastery_Strength_of_the_Ages.png/50px-Mastery_Strength_of_the_Ages.png'
			Case "6263" ;Bond of Stone
				$sKeystoneMastery = $aMasteryList[$i]
				$sMasteryURL = 'http://lol.esportspedia.com/w/images/thumb/e/e2/Mastery_Bond_of_Stone.png/50px-Mastery_Bond_of_Stone.png'
		EndSwitch
	Next
	Return $sMasteryURL
EndFunc

Func GetPNGFromURL($sMasteryURL, $iPosX, $iPosY)
	Local  $STM_SETIMAGE = 0x0172
	Local $hBmp = _GDIPlus_BitmapCreateFromMemory(InetRead($sMasteryURL), True) ;to load an image from the net
	Local  $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp)
	Local  $iWidth = _GDIPlus_ImageGetWidth($hBitmap)
	Local  $iHeight = _GDIPlus_ImageGetHeight($hBitmap)
	Local  $idPic = GUICtrlCreatePic("", $iPosX, $iPosY, $iWidth, $iHeight)
	_WinAPI_DeleteObject(GUICtrlSendMsg($idPic, $STM_SETIMAGE, $IMAGE_BITMAP, $hBmp))
EndFunc


Func _GetURLImage($sURL, $sDirectory = @ScriptDir)
    Local $hDownload, $sFile
    $sFile = StringRegExpReplace($sURL, "^.*/", "")
    If @error Then
        Return SetError(1, 0, $sFile)
    EndIf
    If StringRight($sDirectory, 1) <> "\" Then
        $sDirectory = $sDirectory & "\"
    EndIf
    $sDirectory = $sDirectory & $sFile
    If FileExists($sDirectory) Then
        Return $sDirectory
    EndIf
    $hDownload = InetGet($sURL, $sDirectory, 17, 1)
    While InetGetInfo($hDownload, 2) = 0
        If InetGetInfo($hDownload, 4) <> 0 Then
            InetClose($hDownload)
            Return SetError(1, 0, $sDirectory)
        EndIf
        Sleep(105)
    WEnd
    InetClose($hDownload)
    Return $sDirectory
EndFunc   ;==>_GetURLImage






















Func _Exit()
    _GDIPlus_BitmapDispose($hBitmap)
    _GDIPlus_GraphicsDispose($hContext)
    _GDIPlus_GraphicsDispose($hGraphic)
    _GDIPlus_Shutdown()
    GUIDelete($hGUI_Child)
    GUIDelete($hGUI)
    Exit
EndFunc ;==>_Exit

Func _CreateCustomBk($hGUI, $hexColor, $alpha = "0xAA")
    Local $iWidth = _WinAPI_GetClientWidth($hGUI)
    Local $iHeight = _WinAPI_GetClientHeight($hGUI)
    Local $oBitmap = _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight)
    Local $hGraphics = _GDIPlus_ImageGetGraphicsContext($oBitmap)
    _GDIPlus_GraphicsSetSmoothingMode($hGraphics, 2)
    Local $hBrush = _GDIPlus_BrushCreateSolid($alpha & Hex($hexColor, 6))
    _GDIPlus_GraphicsFillRect($hGraphics, 0, 0, $iWidth, $iHeight, $hBrush)
    _GDIPlus_GraphicsFillRect($hGraphics, 2, 2, $iWidth - 6, $iHeight - 6, $hBrush)
    _GDIPlus_BrushSetSolidColor($hBrush, 0x22FFFFFF)
    Local $iTimes = Round($iWidth / 50)
    Local $aPoints[5][2]
    $aPoints[0][0] = 4
    $aPoints[1][1] = $iHeight
    $aPoints[2][1] = $iHeight
    $aPoints[4][1] = 0
    $aPoints[3][1] = 0
    For $i = 0 To $iTimes
        Local $Random1 = Random(0, $iWidth, 1)
        Local $Random2 = Random(30, 50, 1)
        $aPoints[1][0] = $Random1
        $aPoints[2][0] = $Random1 + $Random2
        $aPoints[4][0] = $aPoints[1][0] + 50
        $aPoints[3][0] = $aPoints[2][0] + 50
        _GDIPlus_GraphicsFillPolygon($hGraphics, $aPoints, $hBrush)
        $aPoints[1][0] -= $Random2 / 10
        $aPoints[2][0] = $Random1 + $Random2 - ($Random2 / 10 * 2)
        $aPoints[3][0] = $aPoints[2][0] + 50
        $aPoints[4][0] = $aPoints[1][0] + 50
        _GDIPlus_GraphicsFillPolygon($hGraphics, $aPoints, $hBrush)
    Next
    _GDIPlus_BrushDispose($hBrush)
    _GDIPlus_GraphicsDispose($hGraphics)
    Return $oBitmap
EndFunc ;==>_CreateCustomBk

Func _CreateCustomGroupPic($hGraphics, $ix, $iy, $Width, $iHeight, $hexColor, $alpha = "0x55")
    _GDIPlus_GraphicsSetSmoothingMode($hGraphics, 2)
    Local $hBrush = _GDIPlus_BrushCreateSolid($alpha & Hex($hexColor, 6))
    _GDIPlus_GraphicsFillRect($hGraphics, $ix, $iy, $Width, $iHeight, $hBrush)
    _GDIPlus_GraphicsFillRect($hGraphics, 2, 2, $Width - 4, $iHeight - 4, $hBrush)
    _GDIPlus_BrushDispose($hBrush)
EndFunc ;==>_CreateCustomGroupPic

Func _SetGuiRoundCorners($hGUI, $iEllipse, $iLeftUp = True, $iLeftDown = True, $iRightUp = True, $iRightDown = True)
    Local $hCornerRgn
    Local $aGuiSize = WinGetPos($hGUI)
    Local $hRgn = _WinAPI_CreateRoundRectRgn(0, 0, $aGuiSize[2], $aGuiSize[3], $iEllipse, $iEllipse)
    If $iLeftUp = False Then
        $hCornerRgn = _WinAPI_CreateRectRgn(0, 0, $aGuiSize[2] / 2, $aGuiSize[3] / 2)
        _WinAPI_CombineRgn($hRgn, $hRgn, $hCornerRgn, $RGN_OR)
        _WinAPI_DeleteObject($hCornerRgn)
    EndIf
    If $iLeftDown = False Then
        $hCornerRgn = _WinAPI_CreateRectRgn(0, $aGuiSize[3] / 2, $aGuiSize[2] / 2, $aGuiSize[3])
        _WinAPI_CombineRgn($hRgn, $hRgn, $hCornerRgn, $RGN_OR)
        _WinAPI_DeleteObject($hCornerRgn)
    EndIf
    If $iRightUp = False Then
        $hCornerRgn = _WinAPI_CreateRectRgn($aGuiSize[2] / 2, 0, $aGuiSize[2], $aGuiSize[3] / 2)
        _WinAPI_CombineRgn($hRgn, $hRgn, $hCornerRgn, $RGN_OR)
        _WinAPI_DeleteObject($hCornerRgn)
    EndIf
    If $iRightDown = False Then
        $hCornerRgn = _WinAPI_CreateRectRgn($aGuiSize[2] / 2, $aGuiSize[3] / 2, $aGuiSize[2] - 1, $aGuiSize[3] - 1)
        _WinAPI_CombineRgn($hRgn, $hRgn, $hCornerRgn, $RGN_OR)
        _WinAPI_DeleteObject($hCornerRgn)
    EndIf
    _WinAPI_SetWindowRgn($hGUI, $hRgn)
EndFunc ;==>_SetGuiRoundCorners

Func SetTransparentBitmap($hGUI, $hImage, $iOpacity = 0xFF)
    Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend
    $hScrDC = _WinAPI_GetDC(0)
    $hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
    $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
    $hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
    $tSize = DllStructCreate($tagSIZE)
    $pSize = DllStructGetPtr($tSize)
    DllStructSetData($tSize, "X", _GDIPlus_ImageGetWidth($hImage))
    DllStructSetData($tSize, "Y", _GDIPlus_ImageGetHeight($hImage))
    $tSource = DllStructCreate($tagPOINT)
    $pSource = DllStructGetPtr($tSource)
    $tBlend = DllStructCreate($tagBLENDFUNCTION)
    $pBlend = DllStructGetPtr($tBlend)
    DllStructSetData($tBlend, "Alpha", $iOpacity)
    DllStructSetData($tBlend, "Format", 1)
    _WinAPI_UpdateLayeredWindow($hGUI, $hMemDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
    _WinAPI_ReleaseDC(0, $hScrDC)
    _WinAPI_SelectObject($hMemDC, $hOld)
    _WinAPI_DeleteObject($hBitmap)
    _WinAPI_DeleteDC($hMemDC)
EndFunc ;==>SetTransparentBitmap

Func _WM_LBUTTONDOWN($hWnd, $iMsg, $wParam, $lParam)
    _SendMessage($hGUI, $WM_SYSCOMMAND, $SC_DRAGMOVE, 0)
EndFunc ;==>_WM_LBUTTONDOWN