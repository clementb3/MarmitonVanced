
function addStep() {
    let ingredientElement = document.getElementById("baseStep").cloneNode(true)
    ingredientElement.id = ""
    document.getElementsByClassName("recipe")[0].insertBefore(ingredientElement, document.querySelector(".recipe > button"))
}

function showRecipeImage() {
    if (document.querySelector('input[type=file]').value == '') {
        document.getElementById('imgRecipe').className = " hide"
        document.getElementById('svgRecipe').className = document.getElementById('svgRecipe').className.replace(" hide","")
    }
    else {
        document.getElementById('svgRecipe').className = " hide"
        document.getElementById('imgRecipe').className = document.getElementById('imgRecipe').className.replace(" hide", "")
    }
}

function removeStep(event) {
    let srcElement = event.srcElement
    while (srcElement.nodeName != "BUTTON")
        srcElement = srcElement.parentNode
    srcElement.parentNode.parentNode.removeChild(srcElement.parentNode)
}

function changeRecipe() {
    for (let recipe of data) {
        if (recipe.Id == document.getElementById("recipeSelect").value) {
            document.getElementById("recipeName").value = recipe.Name
            //document.getElementById("imgRecipe").value = recipe.Image
            document.getElementById("recipeTime").value = recipe.Time
            document.getElementById("recipeCount").value = recipe.CountRecipe
            document.getElementById("recipeType").value = recipe.Type
            for (let element of document.querySelectorAll(".listIngredient .ingredient")) {
                document.querySelector(".listIngredient").removeChild(element)
            }
            for (let ingredient of recipe.Ingredients) {
                addIngredient();
                document.querySelector(".listIngredient .ingredient:last-of-type select").value = ingredient.Id
                document.querySelector(".listIngredient .ingredient:last-of-type input").value = ingredient.Quantity
            }
            for (let element of document.querySelectorAll(".recipe > div")) {
                document.querySelector(".recipe").removeChild(element)
            }
            for (let step of recipe.Steps) {
                addStep();
                document.querySelector(".recipe > div:last-of-type textarea").value = step.Desc
            }
        }
    }
}

function updateRecipe() {
    for (let recipe of data) {
        if (recipe.Id == document.getElementById("recipeSelect").value) {
            recipe.Name = document.getElementById("recipeName").value
            //recipe.Image = document.getElementById("fileRecipe").value
            recipe.Time  = document.getElementById("recipeTime").value 
            recipe.CountRecipe = document.getElementById("recipeCount").value
            recipe.Type = document.getElementById("recipeType").value
            let ingredients = []
            let steps = []
            for (let element of document.querySelectorAll(".listIngredient .ingredient")) {
                ingredients.push({ Id: element.querySelector("select").value, Name: "", Quantity: element.querySelector("input").value, Type: 0 })
            }
            recipe.Ingredients = ingredients
            let pos = 0
            for (let element of document.querySelectorAll(".recipe > div")) {
                pos+=1
                steps.push({ Id: 0, IdRecipe: recipe.Id, Desc: element.querySelector("textarea").value, Pos: pos })
            }
            recipe.Steps = steps


        }
    }
}

function sendData() {
    let body = JSON.stringify(data)
    fetch("../recipe/updateRecipe",
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
            body: body
        }).then(() => {
            location.href="../recipe"
        }).catch((ex) => alert(ex))
}

function removeRecipe() {
    fetch("../recipe/removeRecipe?idRecipe=" + document.getElementById("recipeSelect").value,
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            method: "POST",
        }).then(() => {
            location.href = "../recipe"
        }).catch((ex) => alert(ex))
}