import consumer from "./consumer"

document.addEventListener("turbolinks:load", () => {
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
      chatContainer.insertAdjacentHTML("beforeend", data["chat"])
    }
  })

  const documentElement = document.documentElement
  window.chatMessage = document.getElementById("chat_message")
  window.scrollToBottom = () => {
    window.scroll(0, documentElement.scrollHeight)
  }

  scrollToBottom()

  const chatButton = document.getElementById("chat-button")

  const button_activation = () => {
    if (chatMessage.value === "") {
      chatButton.classList.add("disabled")
    } else {
      chatButton.classList.remove("disabled")
    }
  }

  chatMessage.addEventListener("input", () => {
    button_activation()
    changeLineCheck()
  })

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
      messageContainer.style.paddingBottom = newFooterHeight + "px"
      window.scrollBy(0, footerHeightDiff)
    } else {
      window.scrollBy(0,footerHeightDiff)
      chatContainer.style.paddingBottom = newFooterHeight + "px"
    }
    footerHeight = newFooterHeight
  }
})