function validated(event) {
    let srcElement = event.srcElement
    while (srcElement.nodeName != "BUTTON")
        srcElement = srcElement.parentNode
    if (!srcElement.className.includes("validated"))
        srcElement.className += " validated"
    else
        srcElement.className = srcElement.className.replace("validated", "")

    for (let article of document.getElementsByClassName("validated")) {
        list += article.id + ","
    }
}

function purchase() {
    let list = ""
    for (let article of document.getElementsByClassName("validated")) {
        list += article.id + ","
    }
    list = list.slice(0, -1)
    fetch("purchase /Update",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: list
        }).then(() => { location.href = "../stock" }).catch((ex) => alert(ex))
}