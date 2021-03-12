if (location.pathname.match("stacks/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("stack_name");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("stack_name").value;
      console.log(keyword);
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("li");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("stack_name").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};