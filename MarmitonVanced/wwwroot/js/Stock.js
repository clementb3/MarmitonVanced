


function updateIngredient() {
    let body = "[";
    for (let element of document.querySelectorAll(".listIngredient > .ingredient")) {
        if (element.querySelector("input").value != "")
            body += "{\"id\":" + element.querySelector("select").value + ",\"qte\":" + element.querySelector("input").value + "},"
    }
    body += "]";

    fetch("stock/Update",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: body
        }).catch(() => alert("Veuillez vous connecter"))
}

function validateNewIngredient() {
    let body = "{ \"name\":\"" + document.querySelector(".addIngredient input").value + "\",\"type\":\"" + document.querySelector(".addIngredient select").value + "\"}"
    console.log(body)
    fetch("stock/addingredient",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: body
        }).then(() => {
            location.reload()
        }).catch((ex) => alert(ex))
}