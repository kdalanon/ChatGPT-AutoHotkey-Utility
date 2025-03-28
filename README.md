> [!CAUTION] 
> Please switch to the new and improved [LLM AutoHotkey Assistant](https://github.com/kdalanon/LLM-AutoHotkey-Assistant) as it offers the following features:
> - Type custom prompts manually
> - Interactive Response Window - Chat, Copy, Retry, and see Chat History
> - Auto-Paste functionality
> - Multi-model support that utilizes [OpenRouter.ai](https://openrouter.ai/), not just ChatGPT
> - Sending message to multiple models at the same time
> - Web search
> - And more!

# ChatGPT-AutoHotkey-Utility

## [⏬ Download here](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/releases/latest)

An AutoHotkey script that uses the ChatGPT API to process selected text.

![image](https://github.com/user-attachments/assets/1d7038cf-6907-4287-9450-88e5e687d00a)

![image](https://github.com/user-attachments/assets/25eb6e4b-977f-4249-9701-8506dae0d764)

## How to use

1. Install [AutoHotkey v2](https://www.autohotkey.com/). Note that this script will not work on earlier versions of AutoHotkey.
2. Copy your OpenAI API key [here](https://platform.openai.com/account/api-keys) (you may need to create a new secret key‍)
3. Open `ChatGPT AutoHotkey Utility.ahk` using your favorite text editor
4. Paste your OpenAI API key on the `API_Key` variable

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/a77d1a7d-628b-4155-83ba-2b5569442a50)

5. Launch `ChatGPT AutoHotkey Utility.ahk`
6. Highlight a text that you want to process using ChatGPT API and press the `back quote` key to bring up the menu

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/7615e7b5-c4f0-4a8f-9608-669a021ac38d)

(Image from [emacs.stackexchange.com](https://emacs.stackexchange.com/questions/16749/how-to-set-emacs-to-recognize-backtick-and-tilde-with-a-colemak-keyboard-layout))

## Customizing menu, prompts, APIs, and hotkey

You can customize prompts and the menu order by doing the following:

### Menu

Under `Menus and ChatGPT prompts`, add a menu by adding this code:

```AutoHotkey
MenuPopup.Add("&8 - Text_To_Appear", Function_To_Execute_When_Selected)
```

The character next to the "and" sign (&) is the hotkey for that particular menu that, when pressed, activates it.

You can also add a line separator using this code:

```AutoHotkey
MenuPopup.Add()
```

### Prompt

You can add a prompt using this code:
