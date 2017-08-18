const config = require('./config')
const Telegraf = require('telegraf')
const { reply } = Telegraf
const app = new Telegraf(config.telegramApiKey)

const {
    Extra,
    Markup
} = require('telegraf');

//Add swagger script dependence to use the model: https://app.swaggerhub.com/apis/nsuvorov83/ExchangeBot_DB/
var ExchangeBotDb = require('./swagger');

app.command('start', ({ from, reply }) => {
  
  var api_c = new ExchangeBotDb.UsersApi(); // Allocate the API class we're going to use.

  var userModel = new ExchangeBotDb.User(); // Construct a model instance.
  
  userModel.userName = from.username;
  userModel.chatId = from.id;
  userModel.telegramAcc = from.username;

  var answer = api_c.addNewUser(userModel, function(error, response) {
      if(error) {
        return reply('Пользователь уже добавлен ранее')
      } else {
        return reply('Добро пожаловать!')
      }
  }); // Invoke the service.


})

app.startPolling()
