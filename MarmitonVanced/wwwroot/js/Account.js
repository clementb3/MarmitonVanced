if (!document.cookie.includes("name=A")) {
    document.querySelector(".account > button ").textContent = document.cookie.split("name=")[1].split("")[0].toUpperCase()
    if (document.cookie.split("name=")[1].split("").includes(";"))
        document.getElementById("accountName").textContent = document.cookie.split("name=")[1].split(";")[0]
    else
        document.getElementById("accountName").textContent = document.cookie.split("name=")[1].replace("\"","")

}


function clickAccount() {
    if (!document.cookie.includes("token=") || document.cookie.includes("token=0")) {
        document.getElementById("login").style.visibility = "visible"
    }
    else
        document.getElementById("logout").style.visibility = "visible"

}

function createAccountShow() {
    document.getElementById("login").style.visibility = "hidden"
    document.getElementById("createAccount").style.visibility = "visible"
}

function createAccount() {
    let inputs = document.querySelectorAll("#createAccount input[type=text],#createAccount input[type=password]")
    const content = JSON.stringify({ name: inputs[0].value, surname: inputs[1].value, mail: inputs[2].value, password: inputs[3].value })
    console.log(content)
    fetch(urlBase + "/account/createaccount",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: content
        })
        .then(function (res) {
            res.text().then((text) => {
                document.cookie = "token=" + text
                document.getElementById("createAccount").style.visibility = "hidden"

            })
        })
        .catch(function (res) { console.log(res) })
}

function deco() {
    fetch(urlBase + "/account/Deconnect").then(() => {
        document.cookie = "token=0"
        document.cookie = "name=A"
        document.getElementById("accountName").textContent = ""
    })
    document.getElementById("logout").style.visibility = "hidden"
}

function connectAccount() {
    let inputs = document.querySelectorAll("#login input[type=text],#login input[type=password]")
    const content = JSON.stringify({ mail: inputs[0].value, password: inputs[1].value })
    console.log(content)
    fetch(urlBase + "/account/connectaccount",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: content
        })
        .then(function (res) {
            res.text().then((text) => {
                if (text.includes("error :"))
                    alert(text.split('error :')[1])
                else {
                    document.cookie = "token=" + text.split(";")[0].replace("\"", "")
                    document.cookie = "name=" + text.split(";")[1].replace("\"", "")
                    document.getElementById("login").style.visibility = "hidden"
                    document.querySelector(".account > button ").textContent = text.split(";")[1].split("")[0].toUpperCase()
                    document.getElementById("accountName").textContent = text.split(";")[1].replace("\"", "")
                    location.reload()
                }
            })
        })
        .catch(function (res) { console.log(res) })
}

function handleCredentialResponse(response) {
    // Le token JWT envoyé par Google
    const jwt = response.credential;

    // Décode le token JWT (partie payload uniquement, base64)
    const payload = JSON.parse(atob(jwt.split('.')[1]));

    console.log("ID Token :", jwt);
    console.log("Nom :", payload.name);
    console.log("Email :", payload.email);

    let inputs = document.querySelectorAll("#login input[type=text],#login input[type=password]")
    const content = JSON.stringify({ mail: payload.email, token: jwt, name: payload.name.split(" ")[1], surname: payload.name.split(" ")[0] })
    console.log(content)
    fetch(urlBase + "/account/ConnectAccountGoogle",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: content
        })
        .then(function (res) {
            res.text().then((text) => {
                if (text.includes("error :"))
                    alert(text.split('error :')[1])
                else {
                    document.cookie = "token=" + text.split(";")[0].replace("\"", "")
                    document.cookie = "name=" + text.split(";")[1].replace("\"", "")
                    document.getElementById("login").style.visibility = "hidden"
                    document.querySelector(".account > button ").textContent = text.split(";")[1].split("")[0].toUpperCase()
                    document.getElementById("accountName").textContent = text.split(";")[1].replace("\"", "")
                    location.reload()

                }
            })
        })
        .catch(function (res) { console.log(res) })
}