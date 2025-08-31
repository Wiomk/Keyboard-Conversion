^!r::
    FixRussianEnglishLayout()
return

^!t::
    ChangeCase("toggle")
return

^!a::
    ClipboardOld := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait 0.5
    
    if (Clipboard != "") {
        String := Clipboard
        Clipboard := Transliterate(String)
        Send ^v
        Sleep 100
    }
    Clipboard := ClipboardOld
return

^!q::
    ToggleDesktop()
return

ToggleDesktop() {
    static isMinimized := false
    
    if (isMinimized) {
        WinMinimizeAllUndo
        isMinimized := false
    } else {
        WinMinimizeAll
        isMinimized := true
    }
}

FixRussianEnglishLayout() {
    ClipboardOld := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait 0.5
    
    if (Clipboard != "") {
        String := Clipboard
        Clipboard := ConvertLayout(String)
        Send ^v
        Sleep 100
    }
    
    Clipboard := ClipboardOld
}

ChangeCase(mode) {
    static lastCase := "upper"
    
    ClipboardOld := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait 0.5
    
    if (Clipboard != "") {
        String := Clipboard
        
        if (lastCase = "upper") {
            StringUpper, String, String
            lastCase := "lower"
        } else {
            StringLower, String, String
            lastCase := "upper"
        }
        
        Clipboard := String
        Send ^v
        Sleep 100
    }
    
    Clipboard := ClipboardOld
}

ConvertLayout(String) {
    static en := "qwertyuiop[]asdfghjkl;'zxcvbnm,./"
    static ru := "йцукенгшщзхъфывапролджэячсмитьбю.ё"
    
    Result := ""
    Loop, Parse, String
    {
        Char := A_LoopField
        LowerChar := Format("{:L}", Char)
        
        if (InStr(ru, LowerChar)) {
            Pos := InStr(ru, LowerChar)
            NewChar := SubStr(en, Pos, 1)
            if (Char == Format("{:U}", Char)) {
                Result .= Format("{:U}", NewChar)
            } else {
                Result .= NewChar
            }
        }
        else if (InStr(en, LowerChar)) {
            Pos := InStr(en, LowerChar)
            NewChar := SubStr(ru, Pos, 1)
            if (Char == Format("{:U}", Char)) {
                Result .= Format("{:U}", NewChar)
            } else {
                Result .= NewChar
            }
        }
        else {
            Result .= Char
        }
    }
    return Result
}

Transliterate(text) {
    static map := { "а":"a", "б":"b", "в":"v", "г":"g", "д":"d", "е":"e", "ё":"yo"
                  , "ж":"zh", "з":"z", "и":"i", "й":"y", "к":"k", "л":"l", "м":"m"
                  , "н":"n", "о":"o", "п":"p", "р":"r", "с":"s", "т":"t", "у":"u"
                  , "ф":"f", "х":"kh", "ц":"ts", "ч":"ch", "ш":"sh", "щ":"shch"
                  , "ъ":"", "ы":"y", "ь":"", "э":"e", "ю":"yu", "я":"ya" }
    
    result := ""
    Loop, Parse, text
    {
        char := A_LoopField
        lowerChar := Format("{:L}", char)
        
        if (map.HasKey(lowerChar)) {
            newChar := map[lowerChar]
            result .= (char == Format("{:U}", char)) ? Format("{:U}", newChar) : newChar
        } else {
            result .= char
        }
    }
    return result
}