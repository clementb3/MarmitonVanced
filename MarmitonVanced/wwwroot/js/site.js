let nav = true
if (location.href.split('search=')[1] != undefined)
    document.getElementById('search').value = location.href.split('search=')[1]

if (location.href.split('error=')[1] != undefined)
    if (location.href.split('error=')[1].split("&")[0] == "auth") {
        document.getElementById("error").style.visibility = "visible"
        document.getElementById("erreurMessage").textContent = "Vous n'êtes pas authentifié. Vous ne pourriez pas accès à cette page."
        document.getElementById("validationError").addEventListener("click", () => { location.href = location.href.split("?")[0] })
    }
function showTypeRecipe(id) {
    for (let list of document.getElementsByClassName("list")) {
        list.style.visibility = "hidden"
        list.style.height = "0px"
    }
    document.getElementById(id).style.visibility = "visible"
    document.getElementById(id).style.height = "auto"
    for (let button of document.querySelectorAll(".selectType > button")) {
        button.className ="frame1"
    }
    document.getElementById(id + "Button").className = "frame2"
}

function showMenuNav() {
    if (nav) {
        nav = false
        document.querySelector(".navMenu").style.width = '200px';
    }
    else {
        nav = true
        document.querySelector(".navMenu").style.width = '0';

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

function removeMenu(event) {
    let srcElement = event.srcElement;
    while (srcElement.nodeName != "HTML") {

        if (srcElement.id == "menu" || srcElement.id == "svgmenu" ) {
            return "";
        }
        srcElement = srcElement.parentNode
    }
    document.getElementById("menu").style.width = '0';
}