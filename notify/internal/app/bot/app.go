package botapp

import (
	"log/slog"
	"time"

	"gopkg.in/telebot.v4"
)

type Bot struct {
	Bot *telebot.Bot
	log *slog.Logger
	// router *bot.Router
}

func New(
	log *slog.Logger,
	token string,
	poll time.Duration,
) (*Bot, error) {
	pref := telebot.Settings{
		Token:  token,
		Poller: &telebot.LongPoller{Timeout: poll},
	}
	b, err := telebot.NewBot(pref)
	if err != nil {
		return nil, err
	}

	return &Bot{
		Bot: b,
		log: log,
	}, nil
}

func (b *Bot) Start() error {
	go func() {
		b.log.Info("Bot started")
		b.Bot.Start()
	}()
	return nil
}

func (b *Bot) Stop() {
	b.Bot.Stop()
}
