document.querySelector("html").scrollTop = document.querySelector("html").clientHeight

function SubmitRequest() {
    let requestElement = document.getElementById("request")
    if (requestElement.value.replaceAll(" ","") != "") {
        fetch("ia/requestia",
            {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: "{\"request\":\"" + requestElement.value + "\"}"
            }).then((res) => res.json().then(
                (content) => {

                    let html =
                        "<div class=\"response\">" +
                        "   <div>" +
                        "       <p>Voici les recette qui pourrait corespondre a votre demande :</p>" +
                        "       <ul>"

                    for (let recipe of jQuery.parseJSON(content)) {
                        html += "<li> <a href=\"/Recipe/details?id="+recipe.Id+"\">"+recipe.Name+"</a></li>"
                    }
                    html +=
                        "       </ul>" +
                        "   </div > " +
                        "</div > "
                    document.getElementById("prompts").innerHTML += html
                    document.querySelector("html").scrollTop = document.querySelector("html").clientHeight

                }))
            .catch(() => "Veuillez vous connecter")
        document.getElementById("prompts").innerHTML +=
            "<div class=\"request\">" +
            "   <p>" + requestElement.value + "</p>" +
            "</div > "
        document.querySelector("html").scrollTop = document.querySelector("html").clientHeight
        requestElement.value = "";
    }
}