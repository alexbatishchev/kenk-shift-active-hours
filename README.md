# kenk-shift-active-hours
## Бесконечный откладыватель авто-перезагрузки Windows при обновлениях
* задаёт в качестве начала активных часов текущий час, а в качестве конца — время на 18 часов позже (это максимальная возможная длительность)
* в комплекте идёт инсталлер install.ps1, который копирует скрипт в профиль пользователя и создает задачу в планировщике, стартующую скрипт автоматически каждые полчаса
* в итоге, система корректно сама ходит за апдейтами и устанавливает их, а также сигнализирует о необходимости перезагрузки для завершения обновления, но никогда не перезагружается сама

## Infinite postponer for Windows Update auto-rebooting
* shifts Active Hours to next 18 hours starting now
* installer install.ps1 creates scheduled task starting every 30 minutes 
* you have updates installed automatically, but never Windows auto-rebooted