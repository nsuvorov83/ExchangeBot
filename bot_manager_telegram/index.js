const config = require('./config')
const Telegraf = require('telegraf')
const { reply } = Telegraf
const app = new Telegraf(config.telegramApiKey)

const {
    Extra,
    Markup
} = require('telegraf');

//Add swagger script dependence to use the model: https://app.swaggerhub.com/apis/nsuvorov83/ExchangeBot_DB/
var ExchangeBotDb = require('./swagger/index');

app.command('start', ({ from, reply }) => {
  //Регистрация нового пользователя
  var api_c = new ExchangeBotDb.UsersApi(); // Allocate the API class we're going to use.

  var userModel = new ExchangeBotDb.User(); // Construct a model instance.
  
  userModel.userName = from.username;
  userModel.chatId = from.id;
  userModel.telegramAcc = from.username;

  var answer = api_c.addNewUser(userModel, function(error, response) {
      if(error != null && error.response.body.err == "ER_DUP_ENTRY") {
        return reply('Пользователь уже добавлен ранее')
      } else if (!response && !error) {
        return reply('Добро пожаловать!')
      } else {
        return reply('Другая ошибка')
      }
  }); // Invoke the service.
})

app.command('issuers', ({ from, reply }) => {
  //Список эмитентов
  var api_c = new ExchangeBotDb.IssuersApi(); // Allocate the API class we're going to use.


  var answer = api_c.getIssuers(function(error, response) {
    if (response && response.length > 0) {
      var text_resp = ""
      response.json.forEach(function(element) {
        text_resp += element.short_name + ' - ' + element.full_name + '\n'
      }, this);
      
      return reply(text_resp)

    }
    else if(response && response.length == 0) {
      return reply('Доступных эмитентов нет')
    } else {
      return reply('Ошибка получения списка эмитентов')
    }
  }); // Invoke the service.

  var aaa = 111; 
})

app.startPolling()
