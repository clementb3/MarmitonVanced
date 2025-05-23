let nav = true
if (location.href.split('search=')[1] != undefined)
    document.getElementById('search').value = location.href.split('search=')[1]
function showTypeRecipe(id) {
    for (let list of document.getElementsByClassName("list")) {
        list.style.visibility = "hidden"
        list.style.height = "0px"
    }
    document.getElementById(id).style.visibility = "visible"
    document.getElementById(id).style.height = "auto"
}

function showMenuNav() {
    if (nav) {
        nav = false
        document.querySelector(".navMenu").style.width = '200px';
        document.querySelector(".content div:nth-of-type(2)").style.marginLeft = '200px';
    }
    else {
        nav = true
        document.querySelector(".navMenu").style.width = '0';
        document.querySelector(".content div:nth-of-type(2)").style.marginLeft = '0';

    }
}

function addIngredient() {
    let ingredientElement = document.getElementById("baseIngredient").cloneNode(true)
    ingredientElement.id = ""
    document.getElementsByClassName("listIngredient")[0].insertBefore(ingredientElement, document.querySelector(".listIngredient > button"))
}

function removeIngredient(event) {
    let srcElement = event.srcElement
    while (srcElement.nodeName != "BUTTON")
        srcElement = srcElement.parentNode
    srcElement.parentNode.parentNode.removeChild(srcElement.parentNode)
}

function changeUnite(event) {
    event.srcElement.parentNode.querySelector(".unity").textContent = event.srcElement.selectedOptions[0].getAttribute("unity")
}

