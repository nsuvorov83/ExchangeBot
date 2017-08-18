const config = require('./config')
const Telegraf = require('telegraf')
const { reply } = Telegraf
const app = new Telegraf(config.telegramApiKey)

const {
    Extra,
    Markup
} = require('telegraf');

app.command('start', ({ from, reply }) => {
  console.log('start', from)
  return reply('Welcome!')
})

app.startPolling()