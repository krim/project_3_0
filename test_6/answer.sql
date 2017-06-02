-- Есть таблица Users(id, email), есть таблица Messages(id, user_id, message). Нужно написать sql запрос который вернет 10 пользователей с максимальным кол-ом сообщений
SELECT  u.id, u.email, COUNT(m.id) AS messages_count FROM users u INNER JOIN messages m ON m.user_id = u.id GROUP BY u.id ORDER BY messages_count DESC LIMIT 10
