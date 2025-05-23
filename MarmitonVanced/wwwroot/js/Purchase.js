function validated(event) {
    let srcElement = event.srcElement
    while (srcElement.nodeName != "BUTTON")
        srcElement = srcElement.parentNode
    if (!srcElement.className.includes("validated")) 
        srcElement.className += " validated"
    else
        srcElement.className = srcElement.className.replace("validated", "")
}