let dateSchedule = Date.now
let hourSchedule = 0
let changed = false;

main()
async function main() {
    while (true) {
        await sleep(20)
        if (!changed) {
            updateRecipe()
            changed = true
        }
    }
}
function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function addSchedule(date, hour, event) {
    dateSchedule = date.split(" ")[0]
    hourSchedule = hour
    for (let element of document.querySelectorAll(".recipes > div")) {
        element.parentNode.removeChild(element)
    }
    if (schedule[dateSchedule + "h" + hourSchedule] != undefined) {
        for (let recipe of schedule[dateSchedule + "h" + hourSchedule][0]) {
            addRecipe("entry")
            document.getElementsByClassName("recipes")[0].children[document.getElementsByClassName("recipes")[0].childElementCount - 2].querySelector("select").value = recipe

        }
        for (let recipe of schedule[dateSchedule + "h" + hourSchedule][1]) {
            addRecipe("plat")
            document.getElementsByClassName("recipes")[1].children[document.getElementsByClassName("recipes")[1].childElementCount - 2].querySelector("select").value = recipe

        }
        for (let recipe of schedule[dateSchedule + "h" + hourSchedule][2]) {
            addRecipe("dessert")
            document.getElementsByClassName("recipes")[2].children[document.getElementsByClassName("recipes")[2].childElementCount - 2].querySelector("select").value = recipe

        }
    }


    for (let addElement of document.getElementsByClassName("addSelect")) {
        if (addElement.children[0].className.includes("recipeday"))
            addElement.className = "recipeday"
        else
            addElement.className = "add"
    }
    let srcElement = event.srcElement
    while (srcElement.nodeName != "TD")
        srcElement = srcElement.parentNode
    srcElement.children[0].className += " addSelect"
    document.querySelector(".new").style.visibility = "visible"
    document.getElementById("dateTime").textContent = "Date : " + date.split(" ")[0] + " " + hour + "h"

}

function updateRecipe() {
    for (let i in schedule) {
        if (i != 0) {
            console.log(i)
            let scheduleElement = document.getElementById(i)
            let html = "<div class='recipeday'>"
            for (let recipe of schedule[i][0]) {
                let option = "option[value=\"" + recipe + "\"]"
                html += "<p>" + document.querySelector(option).textContent + "</p>"
            }
            for (let recipe of schedule[i][1]) {
                html += "<p>" + document.querySelector("option[value='" + recipe + "']").textContent + "</p>"
            }
            for (let recipe of schedule[i][2]) {
                html += "<p>" + document.querySelector("option[value='" + recipe + "']").textContent + "</p>"
            }
            html += "</div>"
            scheduleElement.innerHTML = html
        }
    }
}

function changeShedule() {
    changed = false
    let entries = []
    let plats = []
    let desserts = []

    for (let element of document.getElementsByClassName("entry")) {
        if (element.value != "null")
            entries.push(element.value)
    }

    for (let element of document.getElementsByClassName("plat")) {
        if (element.value != "null")
            plats.push(element.value)
    }

    for (let element of document.getElementsByClassName("dessert")) {
        if (element.value != "null")
            desserts.push(element.value)
    }
    schedule[dateSchedule + "h" + hourSchedule] = [entries, plats, desserts]

    let body = "[";
    for (let i in schedule) {
        if (i != 0) {
            body += "{\"" + i + "\":" + JSON.stringify(schedule[i]) + "},"
        }
    }
    body += "]";

    fetch("schedule/update",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: body
        }).catch(() => "Veuillez vous connecter")
}

function removeRecipe(event) {
    let elementClick = event.srcElement
    while (elementClick.nodeName != 'BUTTON')
        elementClick = elementClick.parentNode
    elementClick.parentNode.parentNode.removeChild(elementClick.parentNode)
    changeShedule()
}

function addRecipe(type) {
    if (type == "entry") {
        document.getElementsByClassName("recipes")[0].insertBefore(document.getElementById("baseEntry").cloneNode(true), document.getElementsByClassName("recipes")[0].children[document.getElementsByClassName("recipes")[0].childElementCount - 1])
        document.getElementsByClassName("recipes")[0].children[document.getElementsByClassName("recipes")[0].childElementCount - 2].style.visibility = ""
    }
    if (type == "plat") {
        document.getElementsByClassName("recipes")[1].insertBefore(document.getElementById("basePlat").cloneNode(true), document.getElementsByClassName("recipes")[1].children[document.getElementsByClassName("recipes")[1].childElementCount - 1])
        document.getElementsByClassName("recipes")[1].children[document.getElementsByClassName("recipes")[1].childElementCount - 2].style.visibility = ""
    }
    if (type == "dessert") {
        document.getElementsByClassName("recipes")[2].insertBefore(document.getElementById("baseDessert").cloneNode(true), document.getElementsByClassName("recipes")[2].children[document.getElementsByClassName("recipes")[2].childElementCount - 1])
        document.getElementsByClassName("recipes")[2].children[document.getElementsByClassName("recipes")[2].childElementCount - 2].style.visibility = ""
    }
}