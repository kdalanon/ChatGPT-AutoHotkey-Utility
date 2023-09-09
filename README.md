# ChatGPT-AutoHotkey-Utility

[⏬ Download here](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/releases/latest)

An AutoHotkey script that uses the ChatGPT API to process selected text.

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/e5076d79-26ad-4680-83ee-032a6a805d40)

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/3b1349c8-619f-4cf9-b82f-2289845a4b71)

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

```AutoHotkey
Function_To_Execute_When_Selected(*) {
    ChatGPT_Prompt := "Your prompt here:"
    Status_Message := "Status message that will show while processing the request"
    API_Model := "gpt-4" ; or API_Model := "gpt-3.5-turbo"
    ProcessRequest(ChatGPT_Prompt, Status_Message, API_Model, Retry_Status)
}
```

### APIs

You can edit the API used for each prompt by changing the `API_Model` under each prompt.

![76IxQa4](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/7bd23815-78d8-4629-b69b-7fcea3be5f28)

### Hotkey

You can change the activation hotkey under Hotkey. See [here](https://www.autohotkey.com/docs/v2/KeyList.htm) for the list of possible hotkeys.

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/da257ab3-05d0-4779-87a2-0a2ba6270255)

## Credits

- [AutoHotkey-JSON](https://github.com/cocobelgica/AutoHotkey-JSON) library
- [ai-tools-ahk](https://github.com/ecornell/ai-tools-ahk) for the inspiration
- [Icons8](https://icons8.com/icon/kTuxVYRKeKEY/chatgpt) for the icon
