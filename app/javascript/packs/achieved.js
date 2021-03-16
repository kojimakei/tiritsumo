function achieve() {
  // 表示されているすべてのメモを取得している
  const stacks = document.querySelectorAll(".checklist");
  stacks.forEach(function (stack) {
     if (stack.getAttribute("data-load") != null) {
      return null;
    }
    stack.setAttribute("data-load", "true");
    // メモをクリックした場合に実行する処理を定義している
    stack.addEventListener("click", () => {
      // どのメモをクリックしたのか、カスタムデータを利用して取得している
      const stackId = stack.getAttribute("data-id");
      // Ajaxに必要なオブジェクトを生成している
      const XHR = new XMLHttpRequest();
      // openでリクエストを初期化する
      XHR.open("GET", `/stacks/${stackId}/achieved`, true);
      // レスポンスのタイプを指定する
      XHR.responseType = "json";
      // sendでリクエストを送信する
      XHR.send();
      // レスポンスを受け取った時の処理を記述する
      XHR.onload = () => {
        if (XHR.status != 200) {
          // レスポンスの HTTP ステータスを解析し、該当するエラーメッセージをアラートで表示するようにしている
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          // 処理を終了している
          return null;          
        }
        // レスポンスされたデータを変数itemに代入している
        const item = XHR.response.stack;
        if (item.achieved === true) {
          // 達成状態であれば、灰色に変わるcssを適用するためのカスタムデータを追加している
          stack.setAttribute("data-check", "true");
        } else if (item.achieved === false) {
          // 未達成状態であれば、カスタムデータを削除している
          stack.removeAttribute("data-check");
        }
      };
    });
  });
}
setInterval(achieve, 1000);