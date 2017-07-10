INSERT INTO `users` (`id`, `user_name`, `block_status`, `telegram_acc`, `email`, `country_id`, `town_id`, `sex`, `birth_date`, `name`, `surname`, `chat_id`) VALUES (NULL, 'nsuvorov', '0', 'nsuvorov', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '123');
INSERT INTO `issuers` (`id`, `short_name`, `full_name`, `url_stock`, `url_price_history`) VALUES (NULL, 'SBER', 'Сбербанк (акции обыкновенные)', 'http://www.moex.com/ru/issue.aspx?board=TQBR&code=SBER', NULL);
INSERT INTO `frequency` (`id`, `name`, `good_time`) VALUES (NULL, 'По требованию', '');
INSERT INTO `currencies` (`id`, `short_name`, `full_name`) VALUES (NULL, 'RUB', 'Российский рубль');
INSERT INTO `brokers` (`id`, `short_name`, `full_name`) VALUES (NULL, 'Finam', 'Финам');
INSERT INTO `sources` (`id`, `issuer_id`, `url`, `spider_name`) VALUES (NULL, '1', 'http://www.sberbank.com/ru/investor-relations/ir/news/', '');