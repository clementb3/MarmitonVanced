// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.


function showTypeRecipe(id) {
    for (let list of document.getElementsByClassName("list")) {
        list.style.visibility = "hidden"
        list.style.height = "0px"
    }
    document.getElementById(id).style.visibility = "visible"
    document.getElementById(id).style.height = "auto"
}