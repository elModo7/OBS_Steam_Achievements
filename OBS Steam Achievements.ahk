NumeroLoop := 1
Loop, read, .\Logros.conf
{StringSplit, LineArray, A_LoopReadLine, %A_Tab%
if(NumeroLoop == "1")
{TitulosRead := LineArray1
}else
if(NumeroLoop == "2")
{DescripcionesRead := LineArray1
}else
if(NumeroLoop == "3")
{ImagenesRead := LineArray1
}NumeroLoop++
}StringSplit, Titulos, TitulosRead, |,
StringSplit, Descripciones, DescripcionesRead, |,
StringSplit, Imagenes, ImagenesRead, |,
VersionA := 1
VersionB := 0
IntervaloAnuncio := 10 * 1000
VelocidadTexto := 50
TextToSpeech := 0
VozTextToSpeech := 0
SetTimer, AnimateDesc, 100
#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
v := ComObjCreate("SAPI.SpVoice")
v.Voice := v.GetVoices().Item(VozTextToSpeech)
v.rate := 0
Menu, tray, NoStandard
Menu, tray, add, Configurar
Menu, tray, add
Menu, tray, add, Info
Menu, tray, add, Salir
Gui -Caption +LastFound
Gui Color, 0x00FF00
Gui Add, Picture, vFondo gMoverVentana x0 y94 w240 h96, .\res\backgroundv2.png
Gui Font, Bold cWhite
Gui Add, Text, vTitulo x96 y16 w130 h23 +0x200 Left +BackgroundTrans,
Gui Font
Gui Font, Norm c0xC0C0C0
Gui Add, Text, vDescripcion x96 y40 w140 h50 Left +BackgroundTrans,
Gui Font
Gui Add, Picture, vImagen x15 y109 w64 h64,
WinSet, TransColor, 0x00FF00
PosicionX := A_ScreenWidth - 240
PosicionY := A_ScreenHeight - 130
Gui Show, x%PosicionX% y%PosicionY% w240 h94, LogroSteam
Return
AnimateDesc:
NumeroVectorActual := random(1, Titulos0)
TituloActual := Titulos%NumeroVectorActual%
DescripcionActual := Descripciones%NumeroVectorActual%
ImagenActual := Imagenes%NumeroVectorActual%
TextX := ""
GuiControl, Text, Imagen, %ImagenActual%
Fade("in","Chroma",5,12)
GuiControl, Text, Titulo, %TituloActual%
if(TextToSpeech == 1)
{v.Speak(DescripcionActual, 1)
}Loop, Parse, DescripcionActual,
{TextX = % TextX . A_LoopField
GuiControl, Text, Descripcion, %TextX%
sleep, %VelocidadTexto%
}sleep, 3000
Fade("out","Chroma",5,12)
GuiControl, Text, Descripcion,
GuiControl, Text, Titulo,
Sleep, %IntervaloAnuncio%
return
MoverVentana:
PostMessage, 0xA1, 2,,, A
return
Salir:
ExitApp
random(x, y)
{Random, var, %x%, %y%
return var
}Fade(Type="",Chroma="",Speed=5,Trans=12)
{if Type = In
{GuiControlGet, Fondo, Pos
GuiControlGet, Imagen, Pos
loop, %Trans%
{FondoPosMovida := FondoY - A_Index * 8
GuiControl, Move, Fondo, y%FondoPosMovida%
sleep, 1
}loop, 12
{ImagenPosMovida := ImagenY - A_Index * 8
GuiControl, Move, Imagen, y%ImagenPosMovida%
sleep, 1
}SoundPlay, .\snd\Achievement-mp3-sound.wma
}if Type = Out
{GuiControlGet, Fondo, Pos
GuiControlGet, Imagen, Pos
GuiControl, Move, Imagen, y109
GuiControl, Text, Descripcion,
GuiControl, Text, Titulo,
loop, 12
{FondoPosMovida := FondoY + A_Index * 8
GuiControl, Move, Fondo, y%FondoPosMovida%
sleep, 1
}}}
Configurar:
Gui Config: New, -Caption +LastFound
Gui Config: Color, 0x000000
Gui Config: Font, Bold c0xFFFFFF
Gui Config: Add, CheckBox, gCheckToggleTextToSpeech vCheckTextToSpeech x24 y120 w158 h23 Checked%TextToSpeech%, Usar voz Loquendo
Gui Config: Font
Gui Config: Font, Bold cBlack
Gui Config: Add, Edit, vTextoIntervaloLogro hWndhEdit1 x24 y24 w157 h21 +Number,
Gui Config: Font
DllCall("SendMessage", "Ptr", hEdit1, "UInt", 0x1501, "Ptr", 1, "WStr", "Tiempo entre Logros (" Round((IntervaloAnuncio/1000), 0) ")")
Gui Config: Font, Bold cBlack
Gui Config: Add, Edit, vTextoVelocidadTexto hWndhEdit2 x24 y56 w157 h21 +Number,
Gui Config: Font
DllCall("SendMessage", "Ptr", hEdit2, "UInt", 0x1501, "Ptr", 1, "WStr", "Velocidad Texto (" VelocidadTexto ")")
Gui Config: Font, s15 Bold c0xFF0000
Gui Config: Add, Text, gCerrarGui x188 y-4 w120 h23 +0x200, x
Gui Config: Font
Gui Config: Font, Bold c0xFFFF80
Gui Config: Add, Text, gMoverVentana x0 y0 w185 h18 +0x200 Center, ◄ Mover ►
Gui Config: Font
Gui Config: Font, Bold s15 c0x00FF00
Gui Config: Add, Text, gGuardarAjustes x188 y132 w120 h23 +0x200, v
Gui Config: Font
Gui Config: Font, Bold cBlack
Gui Config: Add, Edit, vTextoNumeroVoz hWndhEdit3 x24 y88 w157 h21 +Number,
Gui Config: Font
DllCall("SendMessage", "Ptr", hEdit3, "UInt", 0x1501, "Ptr", 1, "WStr", "Voz predeterimanada (" VozTextToSpeech ")")
Gui Config: Font
Gui Show, x320 y240 w203 h154, Window
return
GuardarAjustes:
Gui, Submit, NoHide
if(TextoIntervaloLogro)
{IntervaloAnuncio := TextoIntervaloLogro * 1000
}if(TextoVelocidadTexto)
{VelocidadTexto := TextoVelocidadTexto
}if(TextoNumeroVoz == "0")
{VozTextToSpeech := TextoNumeroVoz
v.Voice := v.GetVoices().Item(VozTextToSpeech)
}else
if(TextoNumeroVoz == "1")
{VozTextToSpeech := TextoNumeroVoz
v.Voice := v.GetVoices().Item(VozTextToSpeech)
}Sleep, 100
Gui Config: Destroy
return
CerrarGui:
Gui Config: Destroy
return
CheckToggleTextToSpeech:
Gui, Submit, NoHide
if(TextoNumeroVoz == "0")
{VozTextToSpeech := TextoNumeroVoz
v.Voice := v.GetVoices().Item(VozTextToSpeech)
}else
if(TextoNumeroVoz == "1")
{VozTextToSpeech := TextoNumeroVoz
v.Voice := v.GetVoices().Item(VozTextToSpeech)
}if(CheckTextToSpeech == "1")
{v.Speak("Voz activada", 1)
}TextToSpeech := CheckTextToSpeech
return
Info:
v.Speak("Versión " VersionA " punto  " VersionB, 1)
MsgBox,,Logros de Steam para OBS, Versión %VersionA%.%VersionB% por elModo7
return
