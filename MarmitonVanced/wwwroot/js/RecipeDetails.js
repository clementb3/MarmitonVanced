const ws = new WebSocket("wss://" + location.host + "/ws");
document.addEventListener("mousewheel", onScroll)
window.onbeforeunload = function () {
    fetch('QuitDetails?id=' + location.href.split("id=")[1])
    ws.close(); 

};

ws.onmessage = function (event) {
    goElement(document.querySelectorAll(".recipe > div > p ")[event.data])
};

function send(pos) {
    ws.send(pos);
}

function onScroll(event) {
    let pos;
    if (event.wheelDelta >= 0) {
        pos = getPos(false);
    }
    else {
        pos = getPos(true);
    }
    goElement(pos)
    send([...pos.parentNode.children].indexOf(pos))
}

function goElement(element) {
    window.scrollTo({ top: element.offsetTop - 70 })

}

function getPos(down) {
    if (down) {
        for (let element of document.querySelectorAll(".recipe > div > p ")) {
            if (element.getBoundingClientRect().top > 70) {
                return element
            }
        }
    }
    for (let element of [...document.querySelectorAll(".recipe > div > p")].reverse()) {
        if (element.getBoundingClientRect().top < 0) {
            return element
        }
    }
}