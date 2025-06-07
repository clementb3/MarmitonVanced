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
    fetch(baseuri + "/account/createaccount",
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

function connectAccount() {
    let inputs = document.querySelectorAll("#login input[type=text],#login input[type=password]")
    const content = JSON.stringify({ mail: inputs[0].value, password: inputs[1].value })
    console.log(content)
    fetch(baseuri + "/account/connectaccount",
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
                    document.cookie = "token=" + text
                    document.getElementById("login").style.visibility = "hidden"
                }
            })
        })
        .catch(function (res) { console.log(res) })
}

