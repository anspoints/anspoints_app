// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import { Modal } from "bootstrap"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//= require_tree.

function themeSwitch() {
    const currTheme = $('body').attr("data-theme");
    console.log(currTheme);
    if (currTheme === "light" ) {
        $('body').attr("data-theme", "dark");
    } else {
        $("body").attr("data-theme", "light");
    }
}
  
window.addEventListener("load", () => {
    //$("#themeSwitch").on("click", function (e) {    
    // });
    $('#themeSwitch').on("click", function (event) {
        event.preventDefault();
        const currTheme = $('body').attr("data-theme");
        console.log(currTheme);
        if (currTheme === "light" ) {
            $('body').attr("data-theme", "dark");
        } else {
            $("body").attr("data-theme", "light");
        }
    });
});
