# ChatGPT-AutoHotkey-Utility
An AutoHotkey script that uses the ChatGPT API to process selected text.

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/d8387e7f-48b6-4e2e-892a-b79bf5c7f4fe)

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/3a4adb48-706c-4fe9-96f2-660a3f14a523)

## How to use

1. Install [AutoHotkey v2](https://www.autohotkey.com/). Note that this script will not work on earlier versions of AutoHotkey.
2. Copy your OpenAI API key [here](https://platform.openai.com/account/api-keys) (you may need to create a new secret key‍)
3. Open `ChatGPT AutoHotkey Utility.ahk` using your favorite text editor
4. Paste your OpenAI API key on the `API_Key` variable

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/b6296e87-255b-43ef-a9d2-5918336fb650)

5. Launch `ChatGPT AutoHotkey Utility.ahk`
6. Highlight a text that you want to process using ChatGPT API and press the `back quote` key to bring up the menu

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/93688758-2843-4901-a059-6985d07a659f)

## Customizing menu, prompts, and hotkey

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
    ProcessRequest(ChatGPT_Prompt, Status_Message, Retry_Status)
}
```

### Hotkey

You can change the activation hotkey under Hotkey. See [here](https://www.autohotkey.com/docs/v2/KeyList.htm) for the list of possible hotkeys.

![image](https://github.com/kdalanon/ChatGPT-AutoHotkey-Utility/assets/123705491/1c3c209c-18fd-4a5d-a523-c5da7bf6904b)

## Credits

- [AutoHotkey-JSON](https://github.com/cocobelgica/AutoHotkey-JSON) library
- [ai-tools-ahk](https://github.com/ecornell/ai-tools-ahk) for the inspiration
