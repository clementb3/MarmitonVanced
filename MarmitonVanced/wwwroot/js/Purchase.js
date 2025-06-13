let price = 0
function validated(event) {
    let srcElement = event.srcElement
    while (srcElement.nodeName != "BUTTON")
        srcElement = srcElement.parentNode
    if (!srcElement.className.includes("validated")) {
        srcElement.className += " validated"
        price += parseFloat(srcElement.querySelector(".price").textContent.replace(",","."))
    }
    else {
        srcElement.className = srcElement.className.replace("validated", "")
        price -= parseFloat(srcElement.querySelector(".price").textContent.replace(",", "."))
    }
    document.getElementById("actualPrice").textContent = price

}

function purchase() {
    let list = ""
    for (let article of document.getElementsByClassName("validated")) {
        list += article.id + ","
    }
    list = list.slice(0, -1)
    fetch("purchase/update",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: list
        }).then(() => { location.href = "../stock" }).catch((ex) => alert(ex))
}