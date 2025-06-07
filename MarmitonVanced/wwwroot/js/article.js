updateDecimal()
function updatePriceIngredient(event, id) {
    let parent = event.srcElement

    while (parent.id != "ingredient") {
        parent = parent.parentElement
    }
    if (parent.querySelector("#quantity").value > 0 && parent.querySelector("#price").value > 0) {
        let json = { "id": id, "quantity": parent.querySelector("#quantity").value, "price": parent.querySelector("#price").value.replace(",", ".") }
        fetch("article/update",
            {
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                method: "POST",
                body: JSON.stringify(json)
            }).catch((ex) => alert(ex))
    }
}

function updateDecimal() {

    for (let price of document.querySelectorAll("#price")) {
        if (price.value != undefined) {
            price.value = price.value.replace(",", ".")
            if (price.value.includes(".")) {
                price.value = price.value.slice(0, price.value.indexOf(".") + 3)
            }
        }
    }
}