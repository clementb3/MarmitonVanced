fetch("recipe/getdetails",
).then((res) => res.text().then((text) => {
    console.log(text)
    document.getElementById(text).style.border = "solid 3px white"
}))