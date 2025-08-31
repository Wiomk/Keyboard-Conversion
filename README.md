# Keyboard-Conversion
Небольшой скрипт для более удобного пользования клавиатурой 

Text Transformer - Автоматизация работы с текстом

ГОРЯЧИЕ КЛАВИШИ:

Ctrl + Alt + R - Исправить раскладку
   Пример: ghbdtn → привет

Ctrl + Alt + T - Переключить регистр  
   Пример: Hello → hELLO

Ctrl + Alt + A - Транслитерация (рус→англ)
   Пример: Привет → Privet

Ctrl + Alt + Q - Показать/скрыть рабочий стол

КАК ИСПОЛЬЗОВАТЬ:
1. Выделите текст в любой программе
2. Нажмите комбинацию клавиш
3. Текст автоматически преобразуется

ПРИМЕРЫ:
• ghbdtn → привет (исправление раскладки)
• Hello → hELLO (переключение регистра) 
• Привет → Privet (транслитерация)

Особенности:
• Работает в любых программах
• Не требует установки
• Просто выдели текст и нажми горячие клавиши

Запуск: Просто откройте файл .ahk дважды кликом

Авто запуск:
powershell -Command "Copy-Item -Path 'С:\MYFOLDER\TextConverter.ahk' -Destination '$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\TextConverter.ahk' -Force; Write-Host 'Скрипт скопирован в автозагрузку!'"
Удаление:
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\TextConverter.ahk"
