; Горячие клавиши для исправления раскладки
^!r:: ; Ctrl+Alt+R - исправить раскладку выделенного текста
    FixRussianEnglishLayout()
return

^!t:: ; Ctrl+Alt+T - переключить регистр
    ChangeCase("toggle")
return

^!a:: ; Ctrl+Alt+A - транслитерация рус->англ
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

^!q:: ; Ctrl+Alt+Q - показать/скрыть рабочий стол (переключатель)
    ToggleDesktop()
return

; Функция переключения рабочего стола
ToggleDesktop() {
    static isMinimized := false
    
    if (isMinimized) {
        WinMinimizeAllUndo ; Разворачиваем все окна
        isMinimized := false
    } else {
        WinMinimizeAll ; Сворачиваем все окна
        isMinimized := true
    }
}

; Функция исправления раскладки
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

; Функция изменения регистра
ChangeCase(mode) {
    ClipboardOld := ClipboardAll
    Clipboard := ""
    Send ^c
    ClipWait 0.5
    
    if (Clipboard != "") {
        String := Clipboard
        String := ToggleCase(String)
        Clipboard := String
        Send ^v
        Sleep 100
    }
    
    Clipboard := ClipboardOld
}

; Конвертация раскладки
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
            ; ПРАВИЛЬНОЕ определение регистра
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

; Переключение регистра
ToggleCase(String) {
    Result := ""
    Loop, Parse, String
    {
        Char := A_LoopField
        if (Char >= "A" and Char <= "Z") or (Char >= "А" and Char <= "Я") {
            Result .= Format("{:L}", Char)
        }
        else if (Char >= "a" and Char <= "z") or (Char >= "а" and Char <= "я") {
            Result .= Format("{:U}", Char)
        }
        else {
            Result .= Char
        }
    }
    return Result
}

; Транслитерация рус->англ
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