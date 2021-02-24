import consumer from "./consumer"

window.addEventListener('load', () => {
  // js.erb 内で使用できるように変数を定義
  window.chatContainer = document.getElementById("chat-container")
  if (chatContainer === null) {
    return
  }

  consumer.subscriptions.create("RoomChannel", {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      // サーバー側から受け取ったHTMLを一番最後に加える
      chatContainer.insertAdjacentHTML("beforeend", data["chat"])
    }
  })

  const documentElement = document.documentElement
  window.chatMessage = document.getElementById("chat_message")
  window.scrollToBottom = () => {
    window.scroll(0, documentElement.scrollHeight)
  }
   // 最初にページ一番下へ移動させる
  scrollToBottom()


  // 入力フォームが空のときはボタン無効化
  const chatButton = document.getElementById("chat-button")

  const button_activation = () => {
    if (chatMessage.value === "") {
      chatButton.classList.add("disabled")
    } else {
      chatButton.classList.remove("disabled")
    }
  }

  // フォームに入力した際の動作
  chatMessage.addEventListener("input", () => {
    button_activation()
    changeLineCheck()
  })

   // 送信ボタンが押された時にボタンを無効化
  chatButton.addEventListener("click", () => {
    chatButton.classList.add("disabled")
    changeLineCount(1)
  })

  const maxLineCount = 10

  const getLineCount = () => {
    return (chatMessage.value + "\n").match(/\r?\n/g).length;
  }

  let lineCount = getLineCount()
  let newLineCount

  const changeLineCheck = () => {
    newLineCount = Math.min(getLineCount(), maxLineCount)
    if (lineCount !== newLineCount) {
      changeLineCount(newLineCount)
    }
  }

  const footer =document.getElementById("footer")
  let footerHeight = footer.scrollHeight
  let newFooterHeight, footerHeightDiff

  const changeLineCount = (newLineCount) => {
    chatMessage.rows = lineCount = newLineCount
    newFooterHeight = footer.scrollHeight
    footerHeightDiff = newFooterHeight - footerHeight
    if (footerHeightDiff > 0) {
      chatContainer.style.paddingBottom = newFooterHeight + "px"
      window.scrollBy(0, footerHeightDiff)
    } else {
      window.scrollBy(0,footerHeightDiff)
      chatContainer.style.paddingBottom = newFooterHeight + "px"
    }
    footerHeight = newFooterHeight
  }

  let oldestChatId
  // メッセージの追加読み込みの可否を決定する変数
  window.showAdditionally = true

  window.addEventListener('scroll', () => {
      if (documentElement.scrollTop === 0 && showAdditionally) {
          showAdditionally = false
          // 表示済みのメッセージの内，最も古いidを取得
          oldestChatId = document.getElementsByClassName('chat')[0].id.replace(/[^0-9]/g, '')
          // Ajax を利用してメッセージの追加読み込みリクエストを送る。最も古いメッセージidも送信しておく。
          $.ajax({
              type: 'GET',
              url: '/show_additionally',
              cache: false,
              data: {oldest_chat_id: oldestChatId, remote: true}
          })
      }
  }, {passive: true});
})