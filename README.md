# Тестовое задание для Syntegrico

## Задание B

1. **Создай кастомный объект `Task__c` с полями:**
   - `Subject__c` (Text)
   - `Done__c` (Checkbox, default = false)
   - `DueDate__c` (Date)

2. **Напиши Apex-класс `TaskController`:**
   - `getTasks()` — получить список задач
   - `markDone(Id taskId)` — отметить задачу как выполненную

3. **Создай LWC компонент `taskList`:**
   - Отобрази список задач в HTML-таблице (используй `<table>`, не `lightning-datatable`)
   - Добавь кнопку «Выполнено» рядом с каждой задачей
   - При нажатии кнопки вызови метод `markDone` из контроллера и обнови список

## Структура проекта

- **Классы:** `./force-app/main/default/classes`
- **LWC:** `./force-app/main/default/lwc/taskList`
- **Объект задачи:** `./force-app/main/default/objects/Task__c`